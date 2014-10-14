require 'spec_helper'

describe OrdersController, ':' do
  Order.delete_all
  Order.create :name => 'name', :qty => 123
  let(:order) {Order.all.first}

  %w{index new}.each do |action|
    describe "#{action}" do
      it "renders the '#{action}' template" do
	get action.to_sym
	expect(response.code).to eq('200')
	expect(response).to render_template("rows/#{action}")
	expect(response.body).to eq('')
      end
    end
  end

  %w{edit show}.each do |action|
    describe "#{action}" do
      it "renders the '#{action}' template" do
	get action.to_sym, :id => order.id
	expect(response.code).to eq('200')
	expect(response).to render_template("rows/#{action}")
	expect(response.body).to eq('')
      end
    end
  end

  it 'checking resource' do
    get :show, :id => order.id
    expect(subject.send(:resource)).to eq(order)
    expect(assigns(:order)).to eq(order)
    expect(assigns(:row)).to eq(order)
  end

  it 'checking resources' do
    get :index
    expect(subject.send(:resources).to_a).to be_a_kind_of(Array)
    expect(assigns(:orders).to_a).to be_a_kind_of(Array)
    expect(assigns(:orders)).to eq(Order.all)
    expect(assigns(:rows)).to eq(Order.all)
  end

  it 'checking model_class' do
    get :show, :id => order.id
    expect(subject.send(:model_class)).to eq(Order)
    expect(subject.send(:model_name)).to eq('Order')
    expect(subject.send(:model_symbol)).to eq('order')
    expect(subject.send(:model_symbol_plural)).to eq('orders')
  end

  it 'should update' do
    put :update, { id: order.id, order: {name: 'name'} }
    expect(response).to be_truthy
    expect(response).to redirect_to(action: :edit)
  end

  it 'should update #2' do
    put :update, { id: order.id, commit: 'OK', order: {name: 'name'} }
    expect(response).to be_truthy
    expect(response).to redirect_to(action: :index)
  end

  it 'should not update' do
    put :update, { id: order.id, order: {name: 'error'} }
    expect(response).to be_success
    expect(response).to render_template('rows/edit')
  end

  it 'should not create' do
    post :create, { id: order.id, order: {name: 'error'} }
    expect(response).to be_success
    expect(response).to render_template('rows/new')
  end

end


class CategoriesController < RowsController
  model_class Order
end

describe CategoriesController do
  it 'checking model_class' do
    get :index
    expect(subject.send(:model_class)).to eq(Order)
    expect(subject.send(:model_name)).to eq('Order')
    expect(subject.send(:model_symbol)).to eq('order')
    expect(subject.send(:model_symbol_plural)).to eq('orders')
  end
end
