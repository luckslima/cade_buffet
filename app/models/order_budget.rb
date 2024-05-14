class OrderBudget < ApplicationRecord
  belongs_to :user
  belongs_to :buffet
  belongs_to :order
  belongs_to :payment_method

  validates :valid_until, presence: true
end
