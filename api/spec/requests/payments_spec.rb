require "rails_helper"

RSpec.describe "Payments API", type: :request do
  it "lists recent payments" do
    Payment.create!(amount_cents: 1000, currency: "USD", email: "a@b.co", name: "Donor", idempotency_key: SecureRandom.uuid, status: :captured)
    get "/payments"
    expect(response).to have_http_status(:ok)
    body = JSON.parse(response.body)
    expect(body).to be_a(Array)
    expect(body.first).to include("amount_cents" => 1000, "status" => "captured")
  end

  it "creates a payment idempotently" do
    headers = { "Idempotency-Key" => SecureRandom.uuid }
    payload = { payment: { amount_cents: 2500, currency: "USD", email: "x@y.z", name: "Donor X" } }
    post "/payments", params: payload, headers: headers
    expect(response).to have_http_status(:accepted)
    first = JSON.parse(response.body)

    post "/payments", params: payload, headers: headers
    expect(response).to have_http_status(:ok)
    second = JSON.parse(response.body)
    expect(second["id"]).to eq(first["id"])
  end
end
