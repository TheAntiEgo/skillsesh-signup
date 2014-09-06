class SignupsController < ApplicationController
  before_action :logged_in?, :current_user, :only => [:onboard, :update]
  
  def index
    reset_session
    @users = User.all.limit(15)
  end
  
  def onboard
    @user = @current_user
  end
  
  def update
    @current_user.profile.update(get_params[:profile])
    redirect_to :index, :notice => "Welcome to Skillsesh!"
  end
  
  private
  
  def get_params
    params.require(:user).permit(:profile => [:bio, :skills, {:course => [:goal, :how, :requirements, :duration, :price, :location, :skills]}])
  end    