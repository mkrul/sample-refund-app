class RefundReason < ApplicationRecord
  has_many :refunds

  validates :uniqueness, :name
end