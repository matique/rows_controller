# mostly generated by Rails

require 'test_helper'

class Order::ItemsControllerTest < ActionController::TestCase
  fixtures :all

  def setup
    @order_item = order_items(:one)
  end

  test 'checking model_...' do
    get :index
    assert_equal Order::Item,    @controller.send(:model_class)
    assert_equal 'Order::Item',  @controller.send(:model_name)
    assert_equal 'order_item',   @controller.send(:model_symbol)
    assert_equal 'order_items',  @controller.send(:model_symbol_plural)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:order_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order_item" do
    assert_difference('Order::Item.count') do
      post :create, params: { order_item: { price: @order_item.price } }
    end

##    assert_redirected_to order_item_path(assigns(:order_item))
    assert_redirected_to edit_order_item_path(assigns(:order_item))
  end

  test "should show order_item" do
    get :show, params: { id: @order_item }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @order_item }
    assert_response :success
  end

  test "should update order_item" do
    put :update, params: { id: @order_item,
                order_item: { price: @order_item.price } }
##    assert_redirected_to order_item_path(assigns(:order_item))
    assert_redirected_to edit_order_item_path(assigns(:order_item))
  end

  test "should destroy order_item" do
    assert_difference('Order::Item.count', -1) do
      delete :destroy, params: { id: @order_item }
    end

    assert_redirected_to order_items_path
  end

end
