require 'test_helper'

class TestControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get test_index_url
    assert_response :success
  end

  test "should receive 429 after 200 when hits too many requests" do
    env = ENV.to_hash.merge("RATE_LIMIT" => 2)
    Object.stub_const(:ENV, env) do
      get test_index_url
      assert_response :success

      get test_index_url
      assert_response :too_many_requests
    end
  end
end
