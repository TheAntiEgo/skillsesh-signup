class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.text :goal
      t.text :how
      t.text :requirements
      t.decimal :duration
      t.decimal :price
      t.integer :location
      t.integer :profile_id

      t.timestamps
    end
  end
end
