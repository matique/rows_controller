require 'test_helper'

class OrdersControllerTest < ActionController::TestCase

  test 'respond to :copy' do
    assert @controller.respond_to?(:copy)
    order = Order.create :name => 'name'
    n = Order.all.length

    put :copy, id: order.id
    assert_response :success
    assert_template 'rows/new'
    assert_match /New Order/, response.body
  end

  test 'coverage: multi deletion' do
    delete :multi_deletion
    assert response
    assert_redirected_to orders_url
  end

end
