require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  include AuthHelper

  include Devise::TestHelpers

  def setup
    sign_in users(:one)
    http_login
  end

  test 'should allow user to update their account' do
    p users(:one)
    put :update
    #assert_equal(users(:one).notifications, false)
  end
end