class Message < ActiveRecord::Base
  belongs_to :sender
  belongs_to :receiver
  belongs_to :conversation, :inverse_of => :message
  belongs_to :parent, :class_name => 'Message', :inverse_of => :child
end
