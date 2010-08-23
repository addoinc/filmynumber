class AnalyticsPresenter < Presenter
  
  def each
    @movies_analytics.each { |movie_analytics|  yield movie_analytics }
  end

  def first
    @movies_analytics.first
  end
  
  def seen?(movie_id)
    @movie_opinions[movie_id].nil? ? false : @movie_opinions[movie_id].seen?
  end
  
  def watchable?(movie_id)
    @movie_opinions[movie_id].nil? ? false : @movie_opinions[movie_id].watchable?
  end
  
  def watchable_twice?(movie_id)
    @movie_opinions[movie_id].nil? ? false : @movie_opinions[movie_id].watchable_twice?
  end
  
  def watchable_multi?(movie_id)
    @movie_opinions[movie_id].nil? ? false : @movie_opinions[movie_id].watchable_multi?
  end
  
  def initialize(movie_analytics, user)
    @movies_analytics = movie_analytics
    @movie_opinions = {}
    unless( user.nil? )
      opinions = Opinion.find(
        :all,
        :conditions => ["user_id = ? and movie_id in (?)", user, @movies_analytics.collect(&:movie)]
      )
      opinions.each do |opinion|
        @movie_opinions[opinion.movie_id] = opinion
      end
    end
  end
  
end
