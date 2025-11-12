class PaymentsController < ApplicationController
  def index
    payments = Payment.order(created_at: :desc).limit(50)
    render json: payments.map { |p| PaymentSerializer.render(p) }
  end

  def show
    p = Payment.find(params[:id])
    render json: PaymentSerializer.render(p)
  end

  def create
    key = request.headers["Idempotency-Key"] || SecureRandom.uuid
    attrs = permitted.merge(idempotency_key: key)
    p = Payment.find_by(idempotency_key: key)
    if p
      render json: PaymentSerializer.render(p), status: :ok
      return
    end
    p = Payment.create!(attrs)
    p.update!(status: :authorized)
    CapturePaymentJob.perform_later(p.id)
    render json: PaymentSerializer.render(p), status: :accepted
  end

  def webhook
    id = params.require(:id)
    status = params.require(:status)
    p = Payment.find(id)
    case status
    when "captured"
      p.update!(status: :captured)
    when "failed"
      p.update!(status: :failed)
    end
    head :no_content
  end

  private
  def permitted
    params.require(:payment).permit(:amount_cents, :currency, :email, :name, metadata: {})
  end
end
