require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  test "order can sum up all its items into a total price" do
    order = orders(:one)

    order.items = [items(:one), items(:two)]

    assert_equal order.total_price, 3000
  end

end
