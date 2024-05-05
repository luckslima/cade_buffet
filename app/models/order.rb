class Order < ApplicationRecord
  belongs_to :buffet
  belongs_to :user
  belongs_to :event_type
  has_one :order_budget
  belongs_to :payment_method
  has_many :messages, dependent: :destroy

  enum status: { pending: 0, approved: 1, confirmed: 2, cancelled: 3 }

  validates :number_of_guests, :event_date, presence: true

  before_validation :generate_code

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

end
