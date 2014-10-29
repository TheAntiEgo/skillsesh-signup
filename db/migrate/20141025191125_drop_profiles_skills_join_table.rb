class DropProfilesSkillsJoinTable < ActiveRecord::Migration
  def change
    drop_table :profiles_skills   
  end
end