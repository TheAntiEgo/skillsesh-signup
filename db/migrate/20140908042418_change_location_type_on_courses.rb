class ChangeLocationTypeOnCourses < ActiveRecord::Migration
  def change
    change_column :courses, :location, :string
  end
end
