require 'spec_helper'

describe Order do
  it 'supports method all' do
    Order.should respond_to(:all)
  end
end
