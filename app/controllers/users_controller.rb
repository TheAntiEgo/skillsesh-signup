class UsersController < ApplicationController
  before_action :current_user?
  
  def show
    @profile = User.find(params[:id]).profile
    render :template => 'profiles/show'
  end
end
