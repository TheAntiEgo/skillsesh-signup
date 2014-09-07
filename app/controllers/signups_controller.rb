class SignupsController < ApplicationController
  def index
    session[:remember_token] = User.first.remember_token
    @profiles = Profile.all.limit(15)
  end
  
  def onboard
    @user = @current_user
  end
  
  def first_session
    @course = Course.new
  end
  
  def update
    if get_profile(:user)
      @current_user.profile.update(get_params[:profile])
      redirect_to first_session_path
    else
      @current_user.profile.courses << Course.create(get_course)
      redirect_to root_path
    end      
  end
  
  private
  
  def get_profile
    params.require(:user).permit(:profile => [:bio, :skills, {:course => [:goal, :how, :requirements, :duration, :price, :location, :skills]}])
  end
  
  def get_course
    params.require(:course).permit(:goal, :how, :duration, :price, :location)
  end
end