class ProfilesController < ApplicationController
  respond_to :json, :only => :update
  before_action :authenticated?, :current_user?
  
  def show
    @profile = @user
    @skills = @profile.skills
  end

  def update
    if get_params[:user][:skills]
      @user.add_skills_from_str(get_params[:user])
      return
    else
      @user.update!(get_params[:user])
    end
    render :json => @user
  end
  
  private
  
  def get_params
    params.permit(:user => [:first_name, :last_name, :photo, :bio, :skills])
  end    
  
  helper_method :xeditable?
end