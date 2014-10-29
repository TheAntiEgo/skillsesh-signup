require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  context "message" do
    context "#set_read_at" do
      should "not modify  :read_at if :read is false" do
        m = create(:unread_message)
        assert_nil m.read_at
      end
      should "set :read_at when read status updated" do
        m = create(:unread_message)
        m.update(:read => true)
        assert_not_nil m.read_at      
      end
    end
  end
end
