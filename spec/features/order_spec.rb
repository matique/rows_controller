require 'spec_helper'

describe "Order" do
  before do
    Order.delete_all
  end

  it 'should be created' do
    visit "/orders"
    page.should have_content("is empty")

    click_link "Create"
    fill_in "Name",    :with => "a name"
    click_button "Create"
    page.should have_content("Order created.")
    page.should have_content("Editing Order")

    Order.all.first.name.should == "a name"
  end

  it 'should be deleted' do
    Order.create
    n = Order.all.length
    visit "/orders"
    page.should have_content("Listing Order")

    click_link "Delete"
    page.should have_content("Order deleted.")
    Order.all.length.should == (n - 1)
  end

#  it 'should be copied' do
#    order = Order.create :name => 'name', :qty => '123'
#    n = Order.all.length
#    visit "/orders/#{order.id}/copy"
#    page.should have_content("New")
#    fill_in "Name",    :with => "a name"
#    click_button "Create"
#
#    Order.all.length.should == (n + 1)
#    order2 = Order.find(order.id + 1)
#    order2.name.should_not == order.name
#    order2.qty.should == order.qty
#  end

end
