class Message < ActiveRecord::Base
  belongs_to :sender, class_name: 'User'
  belongs_to :recepient, class_name: 'User'
  belongs_to :conversation
  belongs_to :parent, :class_name => 'Message', :inverse_of => :child
  
  before_save :set_read_status, :on => :update
  after_create :send_notification, :on => :create
  
  protected
  
    def set_read_status
      self.read_at = Time.now.to_datetime if self.read && self.read_at.nil?
    end

    def send_notification
      Notifications.new_message(self).deliver if self.recepient.preference.new_messages
    end
end
