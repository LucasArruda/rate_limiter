module RateLimit
  extend ActiveSupport::Concern

  included do
    before_action :rate_limiter
  end

  def rate(rate)
    @rate = rate
  end

  def period(period)
    @period = period
  end

  protected

  def defined_rate_limit
    @rate || ENV['RATE_LIMIT'] || 99
  end

  def defined_period
    @period || ENV['PERIOD'] || 3599
  end

  def rate_limiter
    count
    increment

    render_too_many_requests and return if blocked?
  end

  def render_too_many_requests
    render json: {
      message: "Rate limit exceeded. Try again in #{cooldown_period} seconds"
    }, status: :too_many_requests
  end

  def count
    unless counter
      $redis.set(client_key, 0)
      $redis.expire(client_key, defined_period)
    end
  end

  def increment
    $redis.incr(client_key)
  end

  def blocked?
    counter.present? && counter.to_i > defined_rate_limit.to_i
  end

  def counter
    $redis.get(client_key)
  end

  def cooldown_period
    $redis.ttl(client_key)
  end

  def client_key
    requester_ip = request.env['REMOTE_ADDR']

    "#{requester_ip}_counter"
  end
end