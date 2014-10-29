class ConversationsOwnMessages < ActiveRecord::Migration
  def change
    change_table :messages do |t|
      t.references :conversation, :index => true
    end
  end
end
