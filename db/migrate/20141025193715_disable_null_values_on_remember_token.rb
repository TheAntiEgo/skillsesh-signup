class DisableNullValuesOnRememberToken < ActiveRecord::Migration
  def change
    change_column :users, :remember_token, :uuid, :null => false, :unique => true, :index => true  
  end
end
