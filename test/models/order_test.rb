require 'test_helper'


describe Order do
  it 'supports method all' do
#    expect(Order).to respond_to(:all)
    assert(Order.respond_to?(:all))
  end
end
