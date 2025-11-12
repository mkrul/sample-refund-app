require "rails_helper"

RSpec.describe CapturePaymentJob, type: :job do
  it "marks small payments as captured" do
    p = Payment.create!(amount_cents: 5000, currency: "USD", email: "t@t.test", name: "T", idempotency_key: SecureRandom.uuid, status: :authorized)
    described_class.perform_now(p.id)
    expect(p.reload.status).to eq("captured")
  end

  it "marks large payments as failed" do
    p = Payment.create!(amount_cents: 200_000, currency: "USD", email: "t@t.test", name: "T", idempotency_key: SecureRandom.uuid, status: :authorized)
    described_class.perform_now(p.id)
    expect(p.reload.status).to eq("failed")
    expect(p.metadata["reason"]).to eq("amount_limit")
  end
end
