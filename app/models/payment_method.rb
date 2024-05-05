class PaymentMethod < ApplicationRecord
  has_many :payment_method_buffets
  has_many :buffets, through: :payment_method_buffets
end
