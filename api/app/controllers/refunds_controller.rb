class RefundsController < ApplicationController
  def index
    render json: refunds
  end

  private

  def refunds
    @refunds ||= Refund.all
  end
end
