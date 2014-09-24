class CoursesController < ApplicationController
  respond_to :json, :only => [:create, :update]
  
  def index
   @courses = Course.where(:profile => current_user?.profile)
  end
  
  def show
    @course = Course.find(params[:id])
  end
  
  def create
    @course = Course.create!(get_params[:course])
    render :json => @course
  end
  
  def update
    @course = Course.find(get_params[:id])
    @course.update!(get_params[:course])
    render :json => @course
  end
  
  private
  
  def get_params
    params.permit :id, :course => [:name, :goal, :how, :requirements, :duration, :price, :location, :skills]
  end
end
