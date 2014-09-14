class CoursesController < ApplicationController
  def index
   @courses = Course.where(:profile => current_user?.profile)
  end
  
  def show
    @course = Course.find(params[:id])
  end
end
