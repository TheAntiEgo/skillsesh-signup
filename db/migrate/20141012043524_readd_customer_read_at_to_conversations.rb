class ReaddCustomerReadAtToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :customer_read_at, :datetime
  end
end
