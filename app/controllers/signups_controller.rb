class SignupsController < ApplicationController
  rescue_from ActiveRecord::ActiveRecordError, :with => :catch_activerecord
  
  def index
    @profiles = Profile.all.limit(15)
  end
  
  def create
    if session[:remember_token] && User.where(:remember_token => session[:remember_token])
      redirect_to(root_path, :notice => "Why don't you share us with your friends instead?") 
      return
    end
    @user = User.new( :email => get_auth[:info][:email], :remember_token => SecureRandom.uuid )
    @user.authentications << Authentication.from_omniauth( get_auth )
    @user.profile = Profile.from_omniauth( get_auth )
    @user.save!
    session[:remember_token] = @user.remember_token
    redirect_to onboard_path
  end
  
  def onboard
    @profile = current_user.profile
  end
  
  def first_session
    @profile = current_user.profile
    @course = Course.new
  end
  
  def update
    if params[:profile]
      current_user.profile.update(params.require(:profile).permit(:bio, :skills))
      redirect_to first_session_path
    else
      current_user.profile.courses << Course.new(params.require(:course).permit(:name, :goal, :how, :duration, :price, :location))
      current_user.save!
      redirect_to root_path, :notice => "That's it! All done!"
    end      
  end
  
  private
  
  def get_auth
    request.env['omniauth.auth']
  end
  
  def catch_activerecord(e)
    logger.error e.exception.to_s
    logger.error e.message.to_s
    redirect_to root_url, :alert => "Something went wrong! Try again or contact us for help"
  end
end