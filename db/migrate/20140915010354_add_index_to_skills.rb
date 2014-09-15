class AddIndexToSkills < ActiveRecord::Migration
  def change
    change_column :skills, :name, :string, :limit => 20, :null => false
    add_index :skills, :name, :unique => true
  end
end
