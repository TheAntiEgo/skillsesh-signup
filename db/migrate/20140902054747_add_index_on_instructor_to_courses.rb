class AddIndexOnInstructorToCourses < ActiveRecord::Migration
  def change
    add_index :courses, :profile_id
  end
end
