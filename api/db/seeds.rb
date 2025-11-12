0.upto(3) do |i|
  Payment.create!(amount_cents: (i + 1) * 500, currency: "USD", email: "demo#{i}@example.com", name: "Donor #{i}", idempotency_key: SecureRandom.uuid, status: :captured)
end
