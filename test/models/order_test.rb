require 'test_helper'

describe Order do
  it 'supports method all' do
    assert Order.respond_to?(:all)
  end
end
