require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should get all users who have not made an order so far' do
    users(:one).orders = [orders(:one)]

    assert_equal [users(:three)], User.users_without_current_orders
  end
end
