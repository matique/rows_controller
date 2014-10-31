require 'test_helper'

require "capybara/rails"
class AcceptanceSpec < Minitest::Spec
  include Capybara::DSL
  include Capybara::Assertions
end


#describe "Order" do
class OrderTest < AcceptanceSpec
  before do
    Order.delete_all
  end

  it 'should be created' do
    visit "/orders"
    page.must_have_content "is empty"

    click_link "Create"
    fill_in "Name",    :with => "a name"
    click_button "Create"
    page.must_have_content "Order created."
    page.must_have_content "Editing Order"

    assert_equal "a name", Order.all.first.name
  end

  it 'should be deleted' do
    Order.create
    n = Order.all.length
    visit "/orders"
    page.must_have_content "Listing Order"

    click_link "Delete"
    page.must_have_content "Order deleted."
    assert_equal n - 1, Order.all.length
  end

  it 'index should have check_box for multi_selection' do
    Order.create :name => 'name', :qty => 123
    visit "/orders"
    page.must_have_css('table tr input[name="multi_selection[]"]')
  end

  it 'should be copied' do
    Order.create :name => 'name', :qty => 123
    order = Order.all.first
    n = Order.all.length
    visit "/orders/#{order.id}/copy"

    page.must_have_content "New"
    fill_in "Name",    :with => "a name"
    click_button "OK"

    assert_equal n + 1, Order.all.length
    order2 = Order.find(order.id + 1)
    refute_equal order.name, order2.name
    assert_equal order.qty, order2.qty
  end

end
