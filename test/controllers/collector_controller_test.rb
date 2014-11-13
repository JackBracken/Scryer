require 'test_helper'

class CollectorControllerTest < ActionController::TestCase
  test "should get receive_event" do
    get :receive_event
    assert_response :success
  end

end
