class LowRateController < ApplicationController
  rate 2
  period 100

  def index; end
end
