require 'test_helper'

describe Order::Item do
  it 'supports method all' do
    assert Order::Item.respond_to?(:all)
  end
end
