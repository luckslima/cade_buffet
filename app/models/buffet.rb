class Buffet < ApplicationRecord
  validates :brand_name, :corporate_name, :registration_number, :phone, 
            :email, :address, :district, :state, :zip_code, :city, presence: true
  validates :user_id, uniqueness: true
  belongs_to :user
  has_many :event_types, dependent: :destroy
  has_many :payment_method_buffets
  has_many :payment_methods, through: :payment_method_buffets
end
