class CapturePaymentJob < ApplicationJob
  queue_as :default
  def perform(payment_id)
    payment = Payment.find(payment_id)
    return unless payment.authorized? || payment.created?
    if payment.amount_cents <= 100000
      payment.update!(status: :captured)
    else
      payment.update!(status: :failed, metadata: payment.metadata.merge(reason: "amount_limit"))
    end
  end
end
