class PaymentSerializer
  def self.render(p)
    {
      id: p.id,
      amount_cents: p.amount_cents,
      currency: p.currency,
      email: p.email,
      name: p.name,
      status: p.status,
      created_at: p.created_at
    }
  end
end
