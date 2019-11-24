require 'test_helper'

class TestControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get test_index_url
    assert_response :success
  end

  test "should receive 429 on too many requests" do
    Object.stub_const(:ENV, {'RATE_LIMIT' => 2}) do
      get test_index_url
      assert_response :success

      get test_index_url
      assert_response :too_many_requests
    end
  end
end
