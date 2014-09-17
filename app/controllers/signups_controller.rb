class SignupsController < ApplicationController
  before_action :authenticated?, :except => [:index, :create]
  before_action :current_user?
  
  def index
    @profiles = Profile.all.limit(15)
  end
  
  def create
    if @user && @user.authentications.find_by(:provider => oauth[:provider], :provider_id => oauth[:uid])
      redirect_back_or_to_root 
    elsif @user
      @user.authentications.create(oauth)
      redirect_back_or_to_root
    else
      @user = User.new( :email => oauth[:info][:email], :remember_token => SecureRandom.uuid )
      @user.authentications << Authentication.from_omniauth(oauth)
      @user.profile = Profile.from_omniauth(oauth)
      @user.save!
      session[:remember_token] = @user.remember_token
      redirect_to onboard_path
    end
  end
  
  def onboard
    byebug
    @profile = @user.profile
  end
  
  def first_session
    @profile = @user.profile
    @course = Course.new
  end
  
  def update
    if params[:profile]
      @user.profile.update!(params.require(:profile).permit(:bio))
      @user.profile.add_skills_from_str(params.require(:profile).permit(:skills))
      @user.save!
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
end