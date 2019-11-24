require 'test_helper'

class TestControllerTest < ActionDispatch::IntegrationTest
  def setup
    $redis.flushdb
  end

  test "should get index" do
    get test_index_url
    assert_response :success
  end

  test "should receive 429 after when already blocked" do
    env = ENV.to_hash.merge("RATE_LIMIT" => 1)
    Object.stub_const(:ENV, env) do
      get test_index_url
      assert_response :success

      get test_index_url
      assert_response :too_many_requests
    end
  end

  test "should receive cooldown message with 429 status" do
    env = ENV.to_hash.merge("RATE_LIMIT" => 1)
    Object.stub_const(:ENV, env) do
      get test_index_url
      assert_response :success

      get test_index_url

      response = JSON.parse(@response.body)

      assert_response :too_many_requests
      assert response['message'].include?('Rate limit exceeded. Try again in ')
      assert response['message'].include?(' seconds')
    end
  end

  test "should receive 429 after 200 when hits too many requests" do
    env = ENV.to_hash.merge("RATE_LIMIT" => 2)
    Object.stub_const(:ENV, env) do
      2.times {
        get test_index_url
        assert_response :success
      }

      get test_index_url
      assert_response :too_many_requests
    end
  end

  test "should receive 200 after cooldown period" do
    env = ENV.to_hash.merge("RATE_LIMIT" => 1, "PERIOD" => 60)
    Object.stub_const(:ENV, env) do
      get test_index_url
      assert_response :success

      get test_index_url
      assert_response :too_many_requests

      travel 61.seconds do
        get test_index_url
        assert_response :success
      end
    end
  end
end
