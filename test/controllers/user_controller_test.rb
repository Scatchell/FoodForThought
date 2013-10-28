require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get user_emails" do
    get :user_emails
    assert_response :success
  end

end
