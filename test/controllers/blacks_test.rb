require "test_helper"

class BlacksControllerTest < ActionController::TestCase
  test "presence of resource_whitelist" do
    assert_raises(RuntimeError) do
      post :create, params: {no_white_list: {name: "Name"}}
    end
  end
end
