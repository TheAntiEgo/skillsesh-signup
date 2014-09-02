class CreateCoursesSkillsJoinTable < ActiveRecord::Migration
  def change
    create_table :courses_skills, id: false do |t|
      t.uuid :course_id
      t.uuid :skill_id
    end

    add_index :courses_skills, :course_id
    add_index :courses_skills, :skill_id
  end
end
