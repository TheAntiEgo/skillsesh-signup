require 'test_helper'

class ConversationTest < ActiveSupport::TestCase
  context "conversation" do
    should accept_nested_attributes_for :messages
    
    context "#is_unread_by" do
      should "return nil if first messsage on the stack is read" do
        c = create :active_conversation, :count => 3
        c.messages.last.read = true
        assert_nil c.is_unread_by
      end
    end
  end
end