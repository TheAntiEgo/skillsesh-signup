class Conversation < ActiveRecord::Base
  belongs_to :customer, class_name: "User"
  belongs_to :merchant, class_name: "User"
  
  ##
  # Instance methods
  ##
  def is_unread_by
    unless self.merchant_read_at.nil?
      if self.customer_read_at < self.merchant_read_at
        self.customer
      else
        self.merchant
      end
    else
      self.merchant
    end
  end
        
end
