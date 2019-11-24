module RateLimit
  extend ActiveSupport::Concern

  included do
    before_action :rate_limiter
  end

  def rate(rate)
    @rate = rate
  end

  protected

  def defined_rate_limit
    @rate || ENV['RATE_LIMIT'] || 99
  end

  def rate_limiter
    count

    render json: { message: 'Rate limit exceeded. Try again in x seconds' },
           status: :too_many_requests
  end

  def count
    requester_ip = request.env['REMOTE_ADDR']
    client_counter_key = "#{requester_ip}_counter"
    $redis.incr(client_key)
  end

    counter = $redis.get(client_counter_key)
  def blocked?
    counter.present? && counter.to_i > defined_rate_limit.to_i
  end

  def counter
    $redis.get(client_key)
  end

  def client_key
    requester_ip = request.env['REMOTE_ADDR']
    client_counter_key = "#{requester_ip}_counter"
  end
end