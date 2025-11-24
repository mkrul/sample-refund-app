0.upto(3) do |i|
  Payment.create!(amount_cents: (i + 1) * 500, currency: "USD", email: "demo#{i}@example.com", name: "Donor #{i}", idempotency_key: SecureRandom.uuid, status: :captured)
end

payments = Payment.all

Refund.create!(
  amount_cents: 500,
  currency: "USD",
  reason: "Customer requested refund",
  payment_id: payments.first.id
)

Refund.create!(
  amount_cents: 1000,
  currency: "USD",
  reason: "Duplicate payment",
  payment_id: payments.second.id
)

Refund.create!(
  amount_cents: 750,
  currency: "USD",
  reason: "Service not provided",
  payment_id: payments.third.id
)

refund_reasons = {
  duplicate_payment: "Customer charged multiple times for same transaction",
  service_not_provided: "Service or product not delivered as expected",
  cancelled_order: "Customer cancelled order before fulfillment",
  defective_product: "Product defective or not as described",
  billing_error: "Incorrect amount charged to customer",
  customer_request: "Customer requested a refund",
  failed_transaction: "Payment processed but service failed",
  policy_violation: "Refund required per policy compliance",
  fraudulent_charge: "Unauthorized or fraudulent transaction",
  other: "Reason not covered by other categories"
}

refund_reasons.each do |key, value|
  RefundReason.create(
    name: key,
    description: value
  )
  iterator += 1
end

