class RemoveNotNullFromBioOnUsers < ActiveRecord::Migration
  def change
    change_column :users, :bio, :text, :limit => 500
  end
end
