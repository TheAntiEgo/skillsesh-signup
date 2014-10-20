class Conversation < ActiveRecord::Base
  belongs_to :customer
  belongs_to :merchant
  belongs_to :course
  has_many :messages, :inverse_of => :conversation

  accepts_nested_attributes_for :messages

  ##
  ## Instance methods
  ##
  def is_unread_by
    if self.messages.last.receiver == self.customer
      return self.merchant
    else
      return self.customer
    end
  end

  def customer_read_at
    return self.messages[-2].created_at if self.messages.count.even? && self.messages.last.read_at.nil?
    return self.messages.last.read_at if self.messages.count.even?
    return self.messages.last.created if self.messages.count.odd?
  end

  def merchant_read_at
    return self.messages[-2].created_at if self.messages.count.odd? && self.messages.last.read_at.nil?
    return self.messages.last.read_at if self.messages.count.odd?
    return self.messages.last.created_at if self.messages.even?
  end

  def newest_first
    self.messages.to_ary.reverse
  end
end
