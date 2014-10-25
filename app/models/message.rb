class Message < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :recepient, class_name: 'User'
  belongs_to :conversation, :inverse_of => :message
  belongs_to :parent, :class_name => 'Message', :inverse_of => :child
end
