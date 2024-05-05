require 'rails_helper'

RSpec.describe Buffet, type: :model do
    describe '#valid?' do
        it 'falso quando nome fantasia é nulo' do
            #Arrange
            user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
            method = PaymentMethod.create!(name: "Boleto Bancário")
            buffet = Buffet.new(brand_name: "", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", 
                                description: "Buffet para casamentos e festas de 15 anos", user: user)
            buffet.payment_methods << method


            #Act
            result = buffet.valid?

            #Assert
            expect(result).to eq false

        end

        it 'falso quando razão social é nulo' do
            #Arrange
            user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
            method = PaymentMethod.create!(name: "Boleto Bancário")
            buffet = Buffet.new(brand_name: "Patty Buffet", corporate_name: "", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", 
                                description: "Buffet para casamentos e festas de 15 anos", user: user)
            buffet.payment_methods << method


            #Act
            result = buffet.valid?

            #Assert
            expect(result).to eq false

        end

        it 'falso quando CNPJ é nulo' do
            #Arrange
            user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
            method = PaymentMethod.create!(name: "Boleto Bancário")
            buffet = Buffet.new(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", 
                                description: "Buffet para casamentos e festas de 15 anos", user: user)
            buffet.payment_methods << method

            #Act
            result = buffet.valid?

            #Assert
            expect(result).to eq false

        end

        it 'falso quando CNPJ é nulo' do
            #Arrange
            user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
            method = PaymentMethod.create!(name: "Boleto Bancário")
            buffet = Buffet.new(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", 
                                description: "Buffet para casamentos e festas de 15 anos", user: nil)
            buffet.payment_methods << method

            #Act
            result = buffet.valid?

            #Assert
            expect(result).to eq false

        end
        
    end
end
