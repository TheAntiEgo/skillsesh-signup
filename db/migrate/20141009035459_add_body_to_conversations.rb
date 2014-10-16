class AddBodyToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :body, :text, array: true
  end
end
