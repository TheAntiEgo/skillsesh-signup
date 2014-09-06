class AddIndexOnInstructorToCourses < ActiveRecord::Migration
  def change
    add_index :courses, :instructor_id
  end
end
