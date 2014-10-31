require 'test_helper'

#class RowsExtController < AcceptanceSpec
describe RowsExtController do
  it "respond to :copy" do
    assert RowsExtController.respond_to?(:copy)
  end
end
