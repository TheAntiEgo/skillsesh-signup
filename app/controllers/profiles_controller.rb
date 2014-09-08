class ProfilesController < ApplicationController
  before_action :logged_in?, :current_user
  
  def show
  end
  
  def update
    @current_user.profile.update(get_params)
    redirect_to :action => :show, :notice => "Profile updated!"
  end
  
  private
  
  def get_params
    params.require(:profile).permit(:first_name, :last_name, :photo, :bio)
  end    
  
end
