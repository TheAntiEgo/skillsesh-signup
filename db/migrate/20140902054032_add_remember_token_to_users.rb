class AddRememberTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :remember_token, :uuid
    add_index :users, :remember_token, unique: true
  end
end
