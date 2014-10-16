class RemoveBodyFieldFromConversations < ActiveRecord::Migration
  def change
    remove_column :conversations, :body
  end
end
