require 'test_helper'

class LowRateControllerTest < ActionDispatch::IntegrationTest
  def setup
    $redis.flushdb
  end

  test 'should get index' do
    get low_rate_index_url
    assert_response :success
  end

  test 'shoud allow only two requests per user per hour on this controller' do
    2.times do
      get low_rate_index_url
      assert_response :success
    end

    get low_rate_index_url
    assert_response :too_many_requests
  end
end
