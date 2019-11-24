if Rails.env.test?
  $redis = MockRedis.new
else
  $redis = Redis.new(Rails.application.config_for(:redis))
end
