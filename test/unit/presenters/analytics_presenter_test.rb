require File.dirname(__FILE__) + '/../../test_helper'
require 'rake'

class AnalyticsPresenterTest < ActiveSupport::TestCase
  
  context "AnalyticsPresenter" do
    
    setup do
      1.upto(20) do
        movie = Factory(:movie, :name => Faker::Name.name)
        theater = Factory(:theater, :name => Faker::Company.name)
        Factory(:show, :movie => movie, :theater => theater)
      end
      @current_user = Factory(:user)
      Factory(:opinion, :user => User.first, :movie => Movie.first)
      
      @rake = Rake::Application.new
      Rake.application = @rake
      load RAILS_ROOT + '/lib/tasks/filmynumber.rake'
    end
    
    should "be presentable when given or not given a user" do
      
      @rake["filmynumber:daily_analytics"].invoke()

      movie_analytics = DailyAnalytics.find(
        :all,
        :include => :movie,
        :conditions => [
          "run_date > ? and run_date < ?", Date.today + 0, (Date.today + 0)+1
        ],
        :order => "show_percent desc"
      )
      analytics = AnalyticsPresenter.new( movie_analytics, @current_user )
      
      analytics.each do
        |analytic|
        assert_not_nil analytic.movie_id
        assert_not_nil analytic.movie_name
        assert_not_nil analytic.show_count
        assert_not_nil analytic.show_percent
      end
      assert analytics.seen?(Movie.first.id)
      assert analytics.watchable?(Movie.first.id)
      assert analytics.watchable_twice?(Movie.first.id)
      assert analytics.watchable_multi?(Movie.first.id)

      non_user_analytics = AnalyticsPresenter.new( movie_analytics, nil )
      non_user_analytics.each do
        |analytic|
        assert_not_nil analytic.movie_id
        assert_not_nil analytic.movie_name
        assert_not_nil analytic.show_count
        assert_not_nil analytic.show_percent
      end
      assert_equal false, non_user_analytics.seen?(Movie.first.id)
      assert_equal false, non_user_analytics.watchable?(Movie.first.id)
      assert_equal false, non_user_analytics.watchable_twice?(Movie.first.id)
      assert_equal false, non_user_analytics.watchable_multi?(Movie.first.id)
    end
    
  end
 
end
