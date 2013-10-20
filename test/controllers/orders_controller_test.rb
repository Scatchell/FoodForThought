require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  include AuthHelper

  include Devise::TestHelpers

  def setup
    sign_in users(:one)
    add_user_to_orders
    http_login
  end

  test 'should destroy an order' do
    session[:auth] = orders(:one).id

    assert_difference('Order.count', -1) do
      delete :destroy, id: orders(:one).id
    end

    assert_redirected_to new_order_path
  end

  test 'should not destroy an order if the authentication token doesn\'t exist' do
    session[:auth] = nil

    assert_difference('Order.count', 0) do
      delete :destroy, id: orders(:one).id
    end

    assert_redirected_to new_order_path
  end

  test 'should display all orders' do
    get :display_all

    assert_equal assigns(:orders).size, 2
  end

  test 'should clear all orders when admin clicks delete all' do
    assert_equal Order.count, 2

    delete :destroy_all

    assert_equal Order.count, 0

    items = Item.all

    items.each do |item|
      assert_equal false, item.available
    end

    assert_redirected_to items_path

    assert_not_nil flash[:notice]
  end

  test 'should save all orders in order history table when admin deletes all orders' do
    assert_equal 2, Order.count
    orders(:one).items = [items(:one),items(:two)]
    orders(:two).items = [items(:two),items(:three)]

    first_order = orders(:one)
    second_order = orders(:two)

    assert_equal 0, OrderHistory.count

    delete :destroy_all

    assert_equal 2, OrderHistory.count

    assert_equal([first_order.user.username, second_order.user.username], OrderHistory.all.to_a.map {|order| order.user.username})
    assert_equal([first_order.items.collect(&:name).sort, second_order.items.collect(&:name).sort], OrderHistory.all.to_a.map {|order| order.items.collect(&:name).sort})
  end

  test 'should get all available items sorted by their item type, and also ordered by their price descending' do
    get :new

    assert_equal({ :food => [items(:one)], :meat => [items(:four),items(:five)],:extra => [items(:three)]}, assigns(:items_by_type))
  end

  test 'should create an order with this users username' do
    post :create, items: [items(:one).id]

    assert_equal users(:one), assigns(:order).user
  end

  test 'should sum up price of each order into total' do
    orders(:one).items = [items(:one), items(:two)]
    orders(:two).items = [items(:three), items(:four)]

    get :display_all

    assert_equal 12000, assigns(:total_price_of_orders)
  end

  private
  def add_user_to_orders
    orders(:one).user = users(:one)
    orders(:two).user = users(:one)

    orders(:one).save!
    orders(:two).save!
  end
end
