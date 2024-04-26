require 'cpf_cnpj'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :cpf, presence: true
  validates :cpf, uniqueness: true
  validate :cpf_valido
         
  has_one :buffet, dependent: :destroy       

  private

  def cpf_valido
    errors.add(:cpf, "não é válido") unless CPF.valid?(cpf)  
  end
end
