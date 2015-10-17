require 'test_helper'

describe Order::ItemsController, ':' do
  Order::Item.delete_all
  Order.create :name => 'name', :qty => 123
  let(:order) {Order.all.first}

  %w{index new}.each do |action|
    describe "#{action}" do
      it "renders the '#{action}' template" do
	get action.to_sym
	assert_response :success
	assert_template "rows/#{action}"
	assert_match /Order/, response.body
      end
    end
  end

#  %w{edit show}.each do |action|
#    describe "#{action}" do
#      it "renders the '#{action}' template" do
#        get action.to_sym, :id => order.id
#        assert_response :success
#        assert_template "rows/#{action}"
#        assert_match /Order/, response.body
#      end
#    end
#  end
#
#  it 'checking resource' do
#    get :show, :id => order.id
#    assert_equal order, @controller.send(:resource)
#    assert_equal order, assigns(:order)
#    assert_equal order, assigns(:row)
#  end
#
#  it 'checking resources' do
#    get :index
#    assert_kind_of Array, @controller.send(:resources).to_a
#    assert_kind_of Array, assigns(:orders).to_a
#    assert_kind_of Array, assigns(:rows).to_a
#    assert_equal Order.all, assigns(:orders)
#  end
#
#  it 'checking model_class' do
#    get :show, :id => order.id
#    assert_equal Order,    @controller.send(:model_class)
#    assert_equal 'Order',  @controller.send(:model_name)
#    assert_equal 'order',  @controller.send(:model_symbol)
#    assert_equal 'orders', @controller.send(:model_symbol_plural)
#  end
#
#  it 'should update' do
#    put :update, { id: order.id, order: {name: 'name'} }
#    assert response
#    assert_redirected_to(action: :edit)
#  end
#
#  it 'should update #2' do
#    put :update, { id: order.id, commit: 'OK', order: {name: 'name'} }
#    assert response
#    assert_redirected_to(action: :index)
#  end
#
#  it 'should not update' do
#    put :update, { id: order.id, order: {name: 'error'} }
#    assert_response :success
#    assert_template 'rows/edit'
#  end
#
#  it 'should not create' do
#    post :create, { id: order.id, order: {name: 'error'} }
#    assert_response :success
#    assert_template 'rows/new'
#  end

end
