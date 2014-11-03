require 'test_helper'

describe OrdersController do

  it "respond to :copy" do
    assert @controller.respond_to?(:copy)
    order = Order.create :name => 'name', :qty => 123
    n = Order.all.length

    put :copy, id: order.id
    assert_response :success
    assert_template "rows/new"
    assert_match /New Order/, response.body
    assert_match /123/, response.body
  end

  it "coverage: multi deletion" do
    delete :multi_deletion
    assert response
    assert_redirected_to orders_url
  end

end
