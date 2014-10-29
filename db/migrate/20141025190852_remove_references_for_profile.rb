class RemoveReferencesForProfile < ActiveRecord::Migration
  def change
    remove_reference :profiles, :user
    remove_reference :courses, :profile
  end
end
