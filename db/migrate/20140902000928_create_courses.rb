class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.text :goal
      t.text :how
      t.text :requirements
      t.decimal :duration
      t.decimal :price
      t.integer :location
      t.integer :instructor_id

      t.timestamps
    end
  end
end
