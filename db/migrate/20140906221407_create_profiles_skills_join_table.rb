class CreateProfilesSkillsJoinTable < ActiveRecord::Migration
  def change
    create_table :profiles_skills, id: false do |t|
      t.integer :profile_id
      t.integer :skill_id
    end
    
    add_index :profiles_skills, :profile_id
    add_index :profiles_skills, :skill_id
  end
end
