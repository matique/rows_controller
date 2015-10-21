require 'test_helper'

class RowsControllerTest < ActionController::TestCase
  test 'respond resource' do
    test_response %i{ resource resources set_resource set_resources }
  end

  test 'respond model' do
    test_response %i{ model_class }
  end

  test 'respond resource format' do
    test_response %i{ resource_format }
  end


  test 'respond action' do
    test_response %i{ index new create show edit update destroy }
  end

  test 'coverage resource_format' do
    assert_equal 'abc', @controller.send(:resource_format, 'abc')
  end

  test 'available public methods' do
    list = %i{create destroy edit index new show update}
    assert_equal list.sort, @controller.public_methods(false).sort
  end

  test 'exposed resource private methods' do
    list = %i{resource resource_format resources set_resource set_resources}
    assert_equal list.sort, filter(@controller.public_methods, 'resource')
  end

  test 'exposed model_ private methods' do
    list = %i{model_class model_name model_symbol model_symbol_plural
	      model_name_from_record_or_class}
    assert_equal list.sort, filter(@controller.public_methods, 'model_')
  end

 private
  def filter(x, criteria)
    x.map(&:to_s).sort.find_all { |x| x =~ /#{criteria}/ }.map(&:to_sym).sort
  end

  def test_response(list)
    list.each { |x|
      assert @controller.respond_to?(x), "controller don't respond to #{x}"
    }
  end

end
