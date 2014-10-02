class ProfilesController < ApplicationController
  respond_to :json, :only => :update
  before_action :authenticated?, :current_user?
  
  def show
    @profile = @user.profile
    @skills = @profile.skills
  end

  def update
    if get_params[:profile][:skills]
      @user.profile.add_skills_from_str(get_params[:profile])
      return
    else
      @user.profile.update!(get_params[:profile])
    end
    render :json => @user.profile
  end
  
  protected 
  
  def xeditable? object = nil
    true # Or something like current_user.xeditable?
  end
  
  private
  
  def get_params
    params.permit(:profile => [:first_name, :last_name, :photo, :bio, :skills])
  end    
  
  helper_method :xeditable?
end