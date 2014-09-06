class UsersController < ApplicationController
  rescue_from ActiveRecord::ActiveRecordError, :with => catch_activerecord_error
  
  def create
    redirect_to root_path, notice: "You're already down with the crew, why don't you share us with your friends?" if Authentication.where(['provider = ? and provider_uid = ?', get_auth.slice(:provider), get_auth.slice(:uid)])
    
    @user = User.new(:email => get_auth[:email], :remember_token => SecureRandom.uuid)
    @user.authentications << Authentication.from_omniauth(get_auth)
    @user.profile = Profile.from_omniauth(get_auth)
    @user.save!
    
    session[:remember_token] = @user.remember_token
    redirect_to onboard_path
  end
  
  private

  def get_auth
    params = ActionController.params.new(request.env['omniauth.auth'])
    params.permit([:provider, :uid, :info => [:first_name, :last_name, :email, :image], :credentials => [:token, :expires_at], :extra => {:raw_info => :pictureUrls}])
  end
  
  def catch_activerecord_error(exception)
    redirect_to root_path, :alert => "Try logging in again"
  end
end
