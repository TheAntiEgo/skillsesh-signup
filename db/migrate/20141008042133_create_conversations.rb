class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.string :subject, null: false
      t.references :customer, index: true
      t.references :merchant, index: true
      t.text :body, array: true
      t.datetime :customer_read_at, default: DateTime.now
      t.datetime :merchant_read_at

      t.timestamps
    end
  end
end
