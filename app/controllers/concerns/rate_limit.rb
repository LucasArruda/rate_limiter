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
end