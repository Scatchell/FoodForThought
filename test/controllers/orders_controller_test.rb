require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  test 'should destroy a post' do
    assert_difference('Order.count', -1) do
      delete :destroy, id: orders(:one).id
    end

    assert_redirected_to new_order_path
  end

  test 'should display all orders' do
    get :display_all

    assert_equal assigns(:orders).size, 2
  end

end
