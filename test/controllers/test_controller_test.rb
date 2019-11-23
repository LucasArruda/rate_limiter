require 'test_helper'

class TestControllerTest < ActionDispatch::IntegrationTest
  test "should receive 429 too many requests" do
    get test_index_url

    assert_response :too_many_requests
  end
end
