class EventType < ApplicationRecord
  validates :name, :description, :min_guests, :max_guests, :duration_minutes,
            :menu_description, :location_type, presence: true
  belongs_to :buffet
  has_many :event_prices, dependent: :destroy
  has_one_attached :image

  enum status: { inactive: 0, active: 1 }

  def calculate_base_price(date, number_of_guests)
    is_weekend = date.saturday? || date.sunday?
  
    event_price = event_prices.find_by(price_for_weekend: is_weekend)  

    return nil if number_of_guests < min_guests || number_of_guests > max_guests

    base_price = event_price.base_price

    if number_of_guests > min_guests
      additional_guests = number_of_guests - min_guests
      base_price += additional_guests * event_price.additional_guest_price
    end

    base_price
  end

end
