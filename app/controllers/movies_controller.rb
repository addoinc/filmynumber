class MoviesController < ApplicationController
  def index
    params[:day] ||= "-1";
    movie_analytics = DailyAnalytics.find(
      :all,
      :include => :movie,
      :conditions => [
        "run_date > ? and run_date < ?", Date.today + params[:day].to_i, (Date.today + params[:day].to_i)+2
      ],
      :order => "show_percent desc"
    )
    @analytics = AnalyticsPresenter.new( movie_analytics, current_user )
    
    if( request_comes_from_facebook? )
      set_facebook_session
      fb_user = Facebooker::User.new(facebook_params['user'], facebook_session)
      unless( fb_user.uid.nil? )
        
      end
      request.xhr? ?
      render(:template => '/movies/facebook_index', :layout => false) :
        render(:template => '/movies/facebook_index', :layout => 'facebook')
    else
      request.xhr? ? render(:template => '/movies/index', :layout => false) : render(:template => '/movies/index')
    end
  end
  
  def series
    params[:movie_id] = params[:movie_id].empty? ? 21 : params[:movie_id]
    @numbers = DailyAnalytics.find(
      :all,
      :select => "movie_name, run_date, show_percent",
      :conditions => ["movie_id = ?", params[:movie_id]]
    );
    
    respond_to do |format|
      format.csv  # series.csv.csv_builder
    end
  end
  
  self.class_eval do
    ['seen', 'watchable', 'watchable_twice', 'watchable_multi'].each do
      |opinion_type|
      define_method(opinion_type.to_sym) {
        unless( current_user.nil? )
          opinion = current_user.opinions.find_or_create_by_movie_id(params[:id])
          opinion.write_attribute(opinion_type.to_sym, params[:opinion])
          opinion.save!
          render :text => "OK"
        else
          render :text => "LOGIN", :status => 403.3
        end
      }
    end
  end
  
end
