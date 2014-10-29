class DropSchedules < ActiveRecord::Migration
  def change
    remove_reference :schedules, :user, :index => true
    drop_table :schedules
  end
end
