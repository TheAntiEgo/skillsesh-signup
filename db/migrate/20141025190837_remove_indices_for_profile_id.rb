class RemoveIndicesForProfileId < ActiveRecord::Migration
  def change
    remove_index :courses, :profile_id
    remove_index :profiles, :user_id
  end
end
