require "test_helper"

class OrdersControllerTest < ActionController::TestCase
  # class OrdersControllerTest < ActionDispatch::IntegrationTest
  # class OrdersControllerTest < ActiveSupport::TestCase
  fixtures :all

  def setup
    @order = orders(:one)
    OrdersController.model_class Order # reset
  end

  test "self.model_class assignment" do
    test_model_class Integer, Integer
    test_model_class "String", String
    test_model_class "ActiveSupport::TimeWithZone", ActiveSupport::TimeWithZone
  end

  %i[index new].each do |action|
    test "renders the '#{action}' template" do
      get action
      assert_response :success
      assert_template "rows/#{action}"
      assert_match(/Order/, response.body)
    end
  end

  %i[edit show].each do |action|
    test "renders the '#{action}' template" do
      get action, params: {id: @order.id}
      assert_response :success
      assert_template "rows/#{action}"
      assert_match(/Order/, response.body)
    end
  end

  test "checking resource" do
    get :show, params: {id: @order.id}
    assert_equal @order, @controller.send(:resource)
    assert_equal @order, assigns(:order)
    assert_equal @order, assigns(:row)
  end

  test "checking resources" do
    get :index
    assert_kind_of Array, @controller.send(:resources).to_a
    assert_kind_of Array, assigns(:orders).to_a
    assert_kind_of Array, assigns(:rows).to_a
    assert_equal Order.all, assigns(:orders)
  end

  test "checking model_class" do
    get :show, params: {id: @order.id}
    assert_equal Order, @controller.send(:model_class)
    assert_equal "Order", @controller.send(:model_name)
    assert_equal "order", @controller.send(:model_symbol)
    assert_equal "orders", @controller.send(:model_symbol_plural)
  end

  test "should create order #2" do
    assert_difference("Order.count") do
      post :create, params: {commit: "OK", order: {name: @order.name}}
    end
  end

  test "should update" do
    put :update, params: {id: @order.id, order: {name: "name"}}
    assert response
    assert_redirected_to(action: :edit)
  end

  test "should update #2" do
    put :update, params: {id: @order.id, commit: "OK", order: {name: "name"}}
    assert response
    assert_redirected_to(action: :index)
  end

  test "should not update; missing OK" do
    put :update, params: {id: @order.id, order: {name: "error"}}
    assert_response :success
    assert_template "rows/edit"
  end

  test "should not create; missing OK" do
    post :create, params: {id: @order.id, order: {name: "error"}}
    assert_response :success
    assert_template "shared/_error_explanation"
  end

  private

  def test_model_class(asgn, klass)
    OrdersController.model_class asgn
    assert_equal klass, OrdersController.model_class
  end
end
