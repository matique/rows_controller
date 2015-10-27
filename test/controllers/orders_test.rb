require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  fixtures :all

  setup do
    @order = orders(:one)
  end

  %i{ index new }.each do |action|
    test "renders the '#{action}' template" do
      get action
      assert_response :success
      assert_template "rows/#{action}"
      assert_match /Order/, response.body
    end
  end

  %i{ edit show }.each do |action|
    test "renders the '#{action}' template" do
      get action, id: @order.id
      assert_response :success
      assert_template "rows/#{action}"
      assert_match /Order/, response.body
    end
  end

  test 'checking resource' do
    get :show, id: @order.id
    assert_equal @order, @controller.send(:resource)
    assert_equal @order, assigns(:order)
    assert_equal @order, assigns(:row)
  end

  test 'checking resources' do
    get :index
    assert_kind_of Array, @controller.send(:resources).to_a
    assert_kind_of Array, assigns(:orders).to_a
    assert_kind_of Array, assigns(:rows).to_a
    assert_equal Order.all, assigns(:orders)
  end

  test 'checking model_class' do
    get :show, id: @order.id
    assert_equal Order,    @controller.send(:model_class)
    assert_equal 'Order',  @controller.send(:model_name)
    assert_equal 'order',  @controller.send(:model_symbol)
    assert_equal 'orders', @controller.send(:model_symbol_plural)
  end

  test "should create order #2" do
    assert_difference('Order.count') do
      post :create, commit: 'OK', order: { name: @order.name }
    end
  end

  test 'should update' do
    put :update, { id: @order.id, order: {name: 'name'} }
    assert response
    assert_redirected_to(action: :edit)
  end

  test 'should update #2' do
    put :update, { id: @order.id, commit: 'OK', order: {name: 'name'} }
    assert response
    assert_redirected_to(action: :index)
  end

  test 'should not update' do
    put :update, { id: @order.id, order: {name: 'error'} }
    assert_response :success
    assert_template 'rows/edit'
  end

  test 'should not create' do
    post :create, { id: @order.id, order: {name: 'error'} }
    assert_response :success
    assert_template 'rows/new'
  end

end
