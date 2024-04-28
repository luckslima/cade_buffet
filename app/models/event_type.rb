class EventType < ApplicationRecord
  validates :name, :description, :min_guests, :max_guests, :duration_minutes,
            :menu_description, :location_type, presence: true
  belongs_to :buffet
  has_many :event_prices, dependent: :destroy
  has_one_attached :image
end
