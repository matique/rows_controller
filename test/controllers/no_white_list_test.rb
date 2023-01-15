require "test_helper"

class NoWhiteList < ApplicationRecord
end

class NoWhiteListController < RowsController
end

class NoWhiteListControllerTest < ActionController::TestCase
  test "presence of resource_whitelist" do
    assert_raises(RuntimeError) do
      post :create, params: {no_white_list: {name: "Name"}}
    end
  end
end
