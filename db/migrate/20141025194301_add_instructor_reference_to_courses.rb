class AddInstructorReferenceToCourses < ActiveRecord::Migration
  def change
    add_reference :courses, :instructor, :index => true
  end
end