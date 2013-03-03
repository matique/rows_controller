require 'spec_helper'

describe OrdersController, ':' do
  Order.delete_all
  Order.create :name => 'name', :qty => 123
  let(:order) {Order.all.first}

  %w{index new}.each do |action|
    describe "#{action}" do
      it "renders the '#{action}' template" do
	get action.to_sym
	response.code.should eq('200')
	response.should render_template("rows/#{action}")
	response.body.should == ''
      end
    end
  end

  %w{edit show}.each do |action|
    describe "#{action}" do
      it "renders the '#{action}' template" do
	get action.to_sym, :id => order.id
	response.code.should eq('200')
	response.should render_template("rows/#{action}")
	response.body.should == ''
      end
    end
  end

  it 'checking resource' do
    get :show, :id => order.id
    subject.send(:resource).should == order
    assigns(:order).should == order
    assigns(:row).should == order
  end

  it 'checking resources' do
    get :index
    subject.send(:resources).should be_a_kind_of(Array)
    assigns(:orders).should be_a_kind_of(Array)
    assigns(:orders).should == Order.all
    assigns(:rows).should == Order.all
  end

  it 'checking model_class' do
    get :show, :id => order.id
    subject.send(:model_class).should == Order
    subject.send(:model_name).should == 'Order'
    subject.send(:model_symbol).should == 'order'
    subject.send(:model_symbol_plural).should == 'orders'
  end

  it 'should update' do
    put :update, { id: order.id }
    response.should be_true
    response.should redirect_to(action: :edit)
  end

  it 'should not update' do
    put :update, { id: order.id, order: {name: 'error'} }
    response.should be_success
    response.should render_template('rows/edit')
  end

  it 'should not create' do
    post :create, { id: order.id, order: {name: 'error'} }
    response.should be_success
    response.should render_template('rows/new')
  end

end


class CategoriesController < RowsController
  model_class Order
end

describe CategoriesController do
  it 'checking model_class' do
    get :index
    subject.send(:model_class).should == Order
    subject.send(:model_name).should == 'Order'
    subject.send(:model_symbol).should == 'order'
    subject.send(:model_symbol_plural).should == 'orders'
  end
end
