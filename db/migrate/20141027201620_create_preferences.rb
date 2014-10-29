class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.boolean :new_messages, :default => true
      t.references :user, :unique => true, :index => true

      t.timestamps
    end
  end
end
