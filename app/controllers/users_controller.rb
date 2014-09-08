class UsersController < ApplicationController
  rescue_from ActiveRecord::ActiveRecordError, :with => :catch_activerecord_error
  
  def index
    @users = Skill.where(:name => get_params[:skill]).users
  end
  
  def create
    redirect_to root_path, notice: "You're already down with the crew, why don't you share us with your friends?" if Authentication.where(['provider = ? and provider_id = ?', get_auth.slice(:provider), get_auth.slice(:uid)])
    
    @user = User.new(:email => get_auth[:info][:email], :remember_token => SecureRandom.uuid)
    @user.authentications << Authentication.from_omniauth(get_auth)
    @user.profile = Profile.from_omniauth(get_auth)
    @user.save!
    
    redirect_to(root_url, :alert => "Something went wrong!") if @error
    session[:remember_token] = @user.remember_token
    byebug
    redirect_to :controller => 'signups', :action => 'onboard'
  end
  
  def show
    @profile = User.find(params[:id]).profile
  end
    
  
  private

  def get_auth
    request.env['omniauth.auth']
  end
  
  def get_params
    params.permit(:skill)
  end
  
  def catch_activerecord_error(exception)
    @error = exception
  end
end
