require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  include AuthHelper

  def setup
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

    assert_equal([first_order.name, second_order.name], OrderHistory.all.to_a.map {|order| order.name})
    assert_equal([first_order.items.collect(&:name).sort, second_order.items.collect(&:name).sort], OrderHistory.all.to_a.map {|order| order.items.collect(&:name).sort})
  end

  test 'should flash error if order is not saved and not redirect to that order' do
    post :create, order: {name: nil}, items: [items(:one).id]

    assert_not_nil flash[:error]
    assert_redirected_to new_order_path
  end

  test 'should get all available items sorted by their item type, and also ordered by their price descending' do
    get :new

    assert_equal({ :food => [items(:three), items(:one)], :meat => [items(:four)] }, assigns(:items_by_type))
  end
end
