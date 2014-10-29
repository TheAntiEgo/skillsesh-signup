class Conversation < ActiveRecord::Base
  belongs_to :customer, class_name: 'User'
  belongs_to :merchant, class_name: 'User'
  belongs_to :course
  has_many :messages
  
  accepts_nested_attributes_for :messages

  ##
  ## Instance methods
  ##
  def is_unread_by
    msgs = self.messages.reverse
    msgs.first.read? ? nil : msgs.first.recepient
  end

end
