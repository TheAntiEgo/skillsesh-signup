class CoursesController < ApplicationController
  respond_to :json, :only => :update
  before_action :current_user?
  
  def index
   @courses = Course.where(:profile => @user.profile)
  end
  
  def show
    @course = Course.find(params[:id])
  end
  
  def create
    @profile = @user
    @course = @user.courses.create!(get_params[:course])
    redirect_to profile_path
  end
  
  def update
    @course = Course.find(get_params[:id])
    @course.update!(get_params[:course])
    render_with @course
  end
  
  private
  
  def get_params
    params.permit :id, :course => [:name, :goal, :how, :requirements, :duration, :price, :skills]
  end
end
