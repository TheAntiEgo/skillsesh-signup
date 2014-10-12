class FixCustomerReadAtOnConversations < ActiveRecord::Migration
  def change
    change_column :conversations, :customer_read_at, :datetime
  end
end
