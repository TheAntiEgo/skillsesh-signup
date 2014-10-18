class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.uuid :sender_id, index: true
      t.uuid :receiver_id, index: true
      t.text :content
      t.datetime :read_at

      t.timestamps
    end
  end
end
