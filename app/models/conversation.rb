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

  def newest_first
    self.messages.to_ary.reverse
  end
  end
end
