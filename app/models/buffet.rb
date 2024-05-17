class Buffet < ApplicationRecord
  validates :brand_name, :corporate_name, :registration_number, :phone, 
            :email, :address, :district, :state, :zip_code, :city, presence: true
  validates :user_id, uniqueness: true
  belongs_to :user
  has_many :event_types, dependent: :destroy
  has_many :payment_method_buffets
  has_many :payment_methods, through: :payment_method_buffets
  has_one_attached :image
  has_many :reviews, dependent: :destroy

  enum status: { inactive: 0, active: 1 }

  def average_rating
    return 0 if reviews.empty?
    reviews.average(:rating).to_f
  end
end
