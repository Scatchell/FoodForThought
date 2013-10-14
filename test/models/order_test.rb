require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  test "order can sum up all its items into a total price" do
    order = orders(:one)

    order.items = [items(:one), items(:two), items(:three)]

    assert_equal 5000, order.total_price
  end

  test "order can sum up all its extra items price" do
    order = orders(:one)

    order.items = [items(:one), items(:two), items(:three)]

    assert_equal 3000, order.get_extra_price
  end

  test "order should calulate Price of all meat Items" do
    order = orders(:one)

    order.items = [items(:four), items(:five)]

    assert_equal 10000, order.get_meat_price
  end

  test "order should calulate Price of a meat Item" do
    order = orders(:one)

    order.items = [items(:five)]

    assert_equal 5000, order.get_meat_price
  end

  test "order should return 3000 if only food items are ordered" do
    order = orders(:one)

    order.items = [items(:one), items(:two)]

    assert_equal 3000, order.total_price
  end

  test 'should print all items in the order' do
    order = orders(:one)

    order.items = [items(:one), items(:two)]

    assert_equal "#{items(:one).name} + #{items(:two).name}", order.items_string

  end
end
