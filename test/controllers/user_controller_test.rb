require 'test_helper'

class UserControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  include AuthHelper

  def setup
    sign_in users(:one)
    http_login
  end

  test 'should get user_emails' do
    get :emails
    assert_response :success
    assert_equal(assigns(:emails), [users(:one).email, users(:three).email])
  end

end
