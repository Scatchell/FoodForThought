require 'test_helper'

class ItemControllerTest < ActionController::TestCase

  def setup
    @controller = ItemsController.new
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
    put :mark_availability, items: ['980190962']

    assert_equal true, items(:one).available
    assert_equal false, items(:two).available
  end

  test 'when all items are selected, they should all be set to available' do
    put :mark_availability, items: [%w(980190962, 298486374)]

    assert_equal true, items(:one).available
    assert_equal true, items(:two).available
  end

  #test 'should update collection' do
  #  put :update, :id => collections(:one), :collection => {:name => 'MyString2'}
  #  assert_equal "MyString2", collections(:one).name
  #end
end
