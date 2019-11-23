module RateLimit
  extend ActiveSupport::Concern

  included do
    before_action :rate_limiter
  end

  protected

  def rate_limiter
    render json: { message: 'Rate limit exceeded. Try again in x seconds' },
           status: :too_many_requests
  end

  def count
    requester_ip = request.env['REMOTE_ADDR']
    client_counter_key = "#{requester_ip}_counter"

    counter = $redis.get(client_counter_key)

    $redis.set(client_counter_key, 0) unless counter

    $redis.incr(client_counter_key)
  end
end