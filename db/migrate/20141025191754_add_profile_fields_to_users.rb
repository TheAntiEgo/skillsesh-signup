class AddProfileFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, :null => false
    add_column :users, :last_name, :string, :null => false
    add_column :users, :bio, :text, :null => false, :limit => 500
    add_column :users, :photo, :string, :null => false
  end
end
