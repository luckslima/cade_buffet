class Order < ApplicationRecord
  belongs_to :buffet
  belongs_to :user
  belongs_to :event_type

  enum status: { pending: 0, approved: 1, confirmed: 2, cancelled: 3 }

  validates :code, :number_of_guests, :event_date, presence: true

  before_validation :generate_code

  private

  def generate_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

end