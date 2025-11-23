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
