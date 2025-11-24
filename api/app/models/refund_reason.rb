class RefundReason < ApplicationRecord
  has_many :refunds

  validates :name, uniqueness: true
  validate :name_is_snake_case, on: %(create update)

  private

  def name_is_snake_case

  end
end