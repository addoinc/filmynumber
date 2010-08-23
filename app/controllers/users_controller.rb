class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def new
    @user = User.new
    request.xhr? ? render(:partial => 'new', :layout => false) : render(:partial => 'new')
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      if request.xhr?
        render :update do
          |page|
          page.call 'sucessful_login'
        end
      else
        flash[:notice] = "Account registered!"
        redirect_back_or_default account_url
      end
    else
      if request.xhr?
        render :update do
          |page|
          page.replace_html(
            'register_dialog',
            :partial => 'new',
            :layout => false
          )
        end
      else
        render :action => :new
      end
    end
  end
  
  def show
    @user = @current_user
  end
  
  def edit
    @user = @current_user
    request.xhr? ? render(:partial => 'edit', :layout => false) : render(:partial => 'edit')
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    ret = @user.update_attributes(params[:user])
    logger.info( " --------------------- " )
    logger.info( @user.login )
    logger.info( ret )
    logger.info( " --------------------- " )
    if @user.update_attributes(params[:user])
      if request.xhr?
        render :update do
          |page|
          page.call 'profile_updated'
        end
      else
        flash[:notice] = "Account updated!"
        redirect_to account_url
      end
    else
      if request.xhr?
        render :update do
          |page|
          page.replace_html(
            'profile_dialog',
            :partial => 'edit',
            :layout => false
          )
        end
      else
        render :action => :edit
      end
    end
  end
end
