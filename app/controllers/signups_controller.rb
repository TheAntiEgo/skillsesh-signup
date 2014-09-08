class SignupsController < ApplicationController
  def index
    @profiles = Profile.all.limit(15)
  end
  
  def create
      @user = User.new( :email => get_auth[:info][:email] )
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
    byebug
    if request.method == 'patch'
      current_user.profile.update(get_profile)
      redirect_to first_session_path
    else
      current_user.profile.courses << Course.new(get_course)
      current_user.save!
      redirect_to root_path, :notice => "That's it! All done!"
    end      
  end
  
  private
  
  def get_profile
    params.require(:profile).permit(:bio, :skills)
  end
  
  def get_course
    params.require(:course).permit(:name, :goal, :how, :duration, :price, :location)
  end
  
  def get_auth
    request.env['omniauth.auth']
  end
end