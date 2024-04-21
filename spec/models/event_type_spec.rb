require 'rails_helper'

RSpec.describe EventType, type: :model do
    describe '#valid?' do
        it 'falso quando nome é nulo' do
            #Arrange
            user = User.create!(name: 'Patricia', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
            buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", description: "Buffet para casamentos e festas de 15 anos", 
                                payment_methods: "Boleto e Cartão", user: user)
            event_type = EventType.new(name: '', description: 'Doces e deliciosas travessuras', min_guests: 50, max_guests: 500, 
                                duration_minutes: 300, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                parking_available: true, location_type: 'on_site', buffet: buffet)

            #Act
            result = event_type.valid?

            #Assert
            expect(result).to eq false
        end

        it 'falso quando quantidade minima de pessoas é nulo' do
            #Arrange
            user = User.create!(name: 'Patricia', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
            buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", description: "Buffet para casamentos e festas de 15 anos", 
                                payment_methods: "Boleto e Cartão", user: user)
            event_type = EventType.new(name: 'Halloween', description: 'Doces e deliciosas travessuras', min_guests: nil, max_guests: 500, 
                                duration_minutes: 300, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                parking_available: true, location_type: 'on_site', buffet: buffet)

            #Act
            result = event_type.valid?

            #Assert
            expect(result).to eq false
        end

        it 'falso quando quantidade máxima de pessoas é nulo' do
            #Arrange
            user = User.create!(name: 'Patricia', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
            buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", description: "Buffet para casamentos e festas de 15 anos", 
                                payment_methods: "Boleto e Cartão", user: user)
            event_type = EventType.new(name: 'Halloween', description: 'Doces e deliciosas travessuras', min_guests: 50, max_guests: nil, 
                                duration_minutes: 300, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                parking_available: true, location_type: 'on_site', buffet: buffet)

            #Act
            result = event_type.valid?

            #Assert
            expect(result).to eq false
        end

        it 'falso quando buffet é nulo' do
            #Arrange
            user = User.create!(name: 'Patricia', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
            buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", description: "Buffet para casamentos e festas de 15 anos", 
                                payment_methods: "Boleto e Cartão", user: user)
            event_type = EventType.new(name: 'Halloween', description: 'Doces e deliciosas travessuras', min_guests: 50, max_guests: 500, 
                                duration_minutes: 300, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                parking_available: true, location_type: 'on_site', buffet: nil)

            #Act
            result = event_type.valid?

            #Assert
            expect(result).to eq false
        end
    end
end
