class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
    request.xhr? ? render(:partial => 'new', :layout => false) : render(:partial => 'new')
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      if request.xhr?
        render :update do
          |page|
          page.call 'sucessful_login'
        end
      else
        flash[:notice] = "Login successful!"
        redirect_back_or_default movies_url
      end
    else
      if request.xhr?
        render :update do
          |page|
          page.replace_html(
            'login_dialog',
            :partial => 'new',
            :layout => false
          )
        end
      else
        render(:action => :new)
      end
    end
  end
  
  def show
    render(:partial => 'user_nav', :layout => false)
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default movies_url
  end
  
end
