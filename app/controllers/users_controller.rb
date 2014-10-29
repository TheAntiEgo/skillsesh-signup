class UsersController < ApplicationController
  before_action :current_user?
  
  def show
    @profile = User.find(params[:id])
    render :template => 'profiles/show'
  end
end
