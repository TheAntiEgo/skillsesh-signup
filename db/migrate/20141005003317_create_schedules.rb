class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.references :user, index: true

      t.timestamps
    end
  end
end
