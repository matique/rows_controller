require 'test_helper'

describe RowsController do
  it "respond" do
    assert @controller.respond_to?(:resource)
    assert @controller.respond_to?(:resources)
    assert @controller.respond_to?(:model_class)
    assert @controller.respond_to?(:model_name)
    assert @controller.respond_to?(:model_symbol)
    assert @controller.respond_to?(:model_symbol_plural)
    assert @controller.respond_to?(:resource_format)

    assert @controller.respond_to?(:index)
    assert @controller.respond_to?(:show)
    assert @controller.respond_to?(:new)
    assert @controller.respond_to?(:edit)
    assert @controller.respond_to?(:create)
    assert @controller.respond_to?(:update)
    assert @controller.respond_to?(:destroy)
  end

  it 'coverage resource_format' do
    assert_equal 'abc', @controller.send(:resource_format, 'abc')
  end

end
