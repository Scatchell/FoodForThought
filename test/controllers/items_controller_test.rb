require 'test_helper'

class ItemsControllerTest < ActionController::TestCase

  include AuthHelper

  def setup
    @controller = ItemsController.new
    http_login
  end

  test 'when item is successfully saved, redirect to view that has all items' do
    post :create, item: {name: 'test_item', price: 1000}

    assert_redirected_to items_path
  end

  test 'when item is successfully saved, its availability should be false' do
    post :create, item: {name: 'test_item', price: 1000}

    assert_equal false, assigns(:item).available
  end

  test 'when no items are selected, set all items to unavailable' do
    put :mark_availability, items: nil

    assert_equal false, items(:one).available
  end

  test 'when 1 items out of 2 are selected, only the selected items should be set to available' do
    put :mark_availability, items: [items(:one).id]

    assert_equal true, items(:one).available
    assert_equal false, items(:two).available
  end

  test 'when all items are selected, they should all be set to available' do
    put :mark_availability, items: %w(980190962, 298486374)

    assert_equal true, items(:one).available
    assert_equal true, items(:two).available
  end


  test 'should delete an item' do
    assert_difference('Item.count', -1) do
      delete :destroy, id: items(:one).id
    end

    assert_not_nil flash[:notice]

    assert_redirected_to items_path
  end

  test 'should list all items ordered by their price descending' do
    get :index

    assert_equal [items(:four), items(:three), items(:one), items(:two)], assigns(:items).to_a
  end
end
