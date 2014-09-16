class ProfilesController < ApplicationController
  before_action :authenticated?, 	:current_user?
  
  def show
    @profile = @user.profile
  end
  
  def update
    @user.profile.update!(get_params)
  end
  
  private
  
  def get_params
    params.permit(:profile => [:first_name, :last_name, :photo, :bio], :course => [:name, :goal, :how, :requirements, :duration, :price, :location, :skills])
  end    
  
end