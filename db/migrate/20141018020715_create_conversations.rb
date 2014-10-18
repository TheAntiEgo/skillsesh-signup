class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.references :customer, index: true
      t.references :merchant, index: true
      t.references :course, index: true

      t.timestamps
    end
  end
end
