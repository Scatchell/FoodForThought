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

  test 'should calculate the price of only extra items' do
    new_extra_item = Item.new(name: 'item_six', price: 2000, item_type: 'extra', available: true)

    new_extra_item.save!

    order = orders(:one)

    order.items = [items(:three), new_extra_item]

    assert_equal 5000, order.total_price
  end

  test 'should calculate the price of an order with no items' do
    order = orders(:one)

    assert_equal 0, order.total_price
  end

  test 'should save all orders to order history when destroyed' do
    orders(:one).items = [items(:one), items(:two)]

    Order.destroy_all

    assert_includes OrderHistory.all.collect(&:items), [items(:one), items(:two)]
  end
end
