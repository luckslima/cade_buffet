class EventType < ApplicationRecord
  validates :name, :description, :min_guests, :max_guests, :duration_minutes,
            :menu_description, :location_type, presence: true
  validates :name, uniqueness: true
  belongs_to :buffet
end
