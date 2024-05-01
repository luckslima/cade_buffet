class OrderBudget < ApplicationRecord
  belongs_to :user
  belongs_to :buffet
  belongs_to :order
end
