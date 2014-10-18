class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :sender, index: true
      t.references :receiver, index: true
      t.text :content
      t.datetime :read_at

      t.timestamps
    end
  end
end
