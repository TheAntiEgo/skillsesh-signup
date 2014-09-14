class SignupsController < ApplicationController
  before_action :current_user?, :except => [:index, :create]
#   rescue_from ActiveRecord::ActiveRecordError, :with => :catch_activerecorderror
  
  def index
    @profiles = Profile.all.limit(15)
  end
  
  def create
    # Already authenticated with this provider so just get the user who owns it
    if Authentication.exists?({:provider => oauth[:provider], :provider_id => oauth[:uid]})
      @user = Authentication.find_by({:provider => oauth[:provider], :provider_id => oauth[:uid]}).user
      session[:remember_token] = @user.remember_token
      redirect_to(request.headers['HTTP_REFERER'], :notice => "Why don't you share us with your friends too!") 
      return
    # Email is unique, so if this user already exists, add this provider to their 
    # collection of authentications and persist the addition
    elsif User.exists?({:email => oauth[:info][:email]})
      @user = User.find_by(:email => oauth[:info][:email])
      @user.authentications << Authentication.from_omniauth(oauth)
      @user.save!
      session[:remember_token] = @user.remember_token
      redirect_to(request.headers['HTTP_REFERER'], :notice => "Why don't you share us with your friends too!") 
      return
    # Brand new user
    else
      @user = User.new( :email => oauth[:info][:email], :remember_token => SecureRandom.uuid )
      @user.authentications << Authentication.from_omniauth( oauth )
      @user.profile = Profile.from_omniauth( oauth )
      @user.save!
    end
    session[:remember_token] = @user.remember_token
    redirect_to onboard_path
  end
  
  def onboard
    @profile = @user.profile
  end
  
  def first_session
    @profile = @user.profile
    @course = Course.new
  end
  
  def update
    if params[:profile]
      @user.profile.update!(params.require(:profile).permit(:bio, :skills))
      redirect_to first_session_path
    else
      @user.profile.courses << Course.create!(params.require(:course).permit(:name, :goal, :how, :duration, :price, :location))
      redirect_to root_path, :notice => "That's it! All done!"
    end      
  end
  
  private
  
  def oauth
    request.env['omniauth.auth']
  end
  
  def catch_activerecorderror(e)
    logger.error e.exception.to_s
    logger.error e.message.to_s
    redirect_to root_url, :alert => "Something went wrong! Try again or contact us for help"
  end
end