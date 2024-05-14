class Order < ApplicationRecord
  belongs_to :buffet
  belongs_to :user
  belongs_to :event_type
  has_one :order_budget
  belongs_to :payment_method
  has_many :messages, dependent: :destroy

  enum status: { pending: 0, approved: 1, confirmed: 2, cancelled: 3 }

  validates :number_of_guests, :event_date, presence: true

  validate :valid_num_guests?

  before_validation :generate_code, on: :create

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def valid_num_guests?
    if !number_of_guests.nil? 
      if number_of_guests < event_type.min_guests || number_of_guests > event_type.max_guests
          errors.add(:number_of_guests, "deve estar entre #{event_type.min_guests} e #{event_type.max_guests}")
      end
    end
  end

end
