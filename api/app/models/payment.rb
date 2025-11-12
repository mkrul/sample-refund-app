class Payment < ApplicationRecord
  enum status: { created: 0, authorized: 1, captured: 2, failed: 3 }
  validates :amount_cents, numericality: { greater_than: 0 }
  validates :email, presence: true
  validates :name, presence: true
  validates :idempotency_key, presence: true, uniqueness: true
end
