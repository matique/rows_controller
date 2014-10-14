require 'spec_helper'

describe "Order" do
  before do
    Order.delete_all
  end

  it 'should be created' do
    visit "/orders"
    expect(page).to have_content("is empty")

    click_link "Create"
    fill_in "Name",    :with => "a name"
    click_button "Create"
    expect(page).to have_content("Order created.")
    expect(page).to have_content("Editing Order")

    expect(Order.all.first.name).to eq("a name")
  end

  it 'should be deleted' do
    Order.create
    n = Order.all.length
    visit "/orders"
    expect(page).to have_content("Listing Order")

    click_link "Delete"
    expect(page).to have_content("Order deleted.")
    expect(Order.all.length).to eq((n - 1))
  end

  it 'index should have check_box for multi_selection' do
    Order.create :name => 'name', :qty => 123
    visit "/orders"
    expect(page).to have_css('table tr input[name="multi_selection[]"]')
  end

  it 'should be copied' do
    Order.create :name => 'name', :qty => 123
    order = Order.all.first
    n = Order.all.length
    visit "/orders/#{order.id}/copy"

    expect(page).to have_content("New")
    fill_in "Name",    :with => "a name"
    click_button "OK"

    expect(Order.all.length).to eq(n + 1)
    order2 = Order.find(order.id + 1)
    expect(order2.name).to_not eq(order.name)
    expect(order2.qty).to eq(order.qty)
  end

end
