class RemoveCustomerReadAtFromConversations < ActiveRecord::Migration
  def change
    remove_column :conversations, :customer_read_at
  end
end
