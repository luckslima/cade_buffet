class Review < ApplicationRecord
  belongs_to :buffet
  belongs_to :user

  has_many_attached :photos

  validates :rating, presence: true
  validates :rating, inclusion: { in: 0..5 }
  validates :comment, presence: true
end
