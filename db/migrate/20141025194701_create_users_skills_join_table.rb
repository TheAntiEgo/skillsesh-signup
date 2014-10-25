class CreateUsersSkillsJoinTable < ActiveRecord::Migration
  def change
    create_table :users_skills, :id => false do |t|
      t.integer :user_id, :index => true
      t.integer :skill_id, :index => true
    end
  end
end
