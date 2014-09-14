require 'test_helper'

class EmailsControllerTest < ActionController::TestCase
  test "POST #create" do
    xhr :post, :create, {:email => "roughjacket@gmail.com"}
    assert_instance_of Gibbon, 'gb'
  end
end
