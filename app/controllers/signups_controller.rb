class SignupsController < ApplicationController
  before_action :authenticated?, :except => [:index, :create]
  before_action :current_user?
  
  def index
    @profiles = User.limit(15).order("RANDOM()")
  end
  
  def create
    if @user && @user.authentications.exists?(:provider => oauth[:provider], :provider_id => oauth[:uid])
      redirect_back_or_to_root
    elsif @user && !Authentication.has_omniauth?(oauth)
      @user.authentications.create(:provider => oauth[:provider], :provider_id => oauth[:uid])
      redirect_back_or_to_root
    elsif !@user && Authentication.has_omniauth?(oauth)
      @user = Authentication.with_omniauth(oauth).user
      set_remember_token @user
      redirect_back_or_to_root
    else
      @user = User.new( :email => oauth[:info][:email], :remember_token => SecureRandom.uuid )
      @user.authentications << Authentication.from_omniauth(oauth)
      @user.profile = Profile.from_omniauth(oauth)
      @user.build_preference
      @user.save!
      set_remember_token @user
      redirect_to onboard_path
    end
  end
  
  def onboard
    @profile = @user
  end
  
  def first_session
    @profile = @user
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