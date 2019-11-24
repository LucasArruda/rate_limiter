require 'test_helper'

class DummyController < ActionController::Base
  include RateLimit
  rate 1
  period 60
end

class DummyControllerTest < ActiveSupport::TestCase
  def setup
    @dummy = DummyController.new
  end

  test 'defines rate correctly' do
    assert_equal @dummy.send(:defined_rate_limit), 1
  end

  test 'defines period correctly' do
    assert_equal @dummy.send(:defined_period), 60
  end
end
