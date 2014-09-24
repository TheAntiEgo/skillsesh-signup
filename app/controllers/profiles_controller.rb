class ProfilesController < ApplicationController
  respond_to :json, :only => :update
  before_action :authenticated?, :current_user?
  
  def show
    @profile = @user.profile
  end

  def update
    @user.profile.update!(get_params[:profile])
    render :json => @user.profile
  end
  
  protected 
  
  def xeditable? object = nil
    true # Or something like current_user.xeditable?
  end
  
  private
  
  def get_params
    params.permit(:profile => [:first_name, :last_name, :photo, :bio], :course => [:name, :goal, :how, :requirements, :duration, :price, :location, :skills])
  end    
  
  helper_method :xeditable?
end