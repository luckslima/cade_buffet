class EventPrice < ApplicationRecord
  validates :base_price, :additional_guest_price, :extra_hour_price, presence: true
  belongs_to :event_type
end
