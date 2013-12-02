require 'test_helper'

class UserControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  include AuthHelper

  def setup
    sign_in users(:one)
    http_login
  end

  test 'should redirect to root page after sending emails' do
    get :emails
    assert_not_nil flash[:notice]
    assert_redirected_to items_path
  end

end
