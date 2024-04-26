require 'rails_helper'

RSpec.describe EventPrice, type: :model do

    describe '#valid?' do
        it 'falso quando preço base é nulo' do
            #Arrange
            user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
            buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", description: "Buffet para casamentos e festas de 15 anos", 
                                payment_methods: "Boleto e Cartão", user: user)
            event_type = EventType.create!(name: 'Halloween', description: 'Doces e deliciosas travessuras', min_guests: 50, max_guests: 500, 
                                duration_minutes: 300, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                parking_available: true, location_type: 'on_site', buffet: buffet)
                                event_price = EventPrice.new(base_price: nil, additional_guest_price: 200, 
                                                                 extra_hour_price: 600, price_for_weekend: true, event_type: event_type)

            #Act
            result = event_price.valid?

            #Assert
            expect(result).to eq false
        end

        it 'falso quando valor por pessoa adicional é nulo' do
            #Arrange
            user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
            buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", description: "Buffet para casamentos e festas de 15 anos", 
                                payment_methods: "Boleto e Cartão", user: user)
            event_type = EventType.create!(name: 'Halloween', description: 'Doces e deliciosas travessuras', min_guests: 50, max_guests: 500, 
                                duration_minutes: 300, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                parking_available: true, location_type: 'on_site', buffet: buffet)
                                event_price = EventPrice.new(base_price: 5000, additional_guest_price: nil, 
                                                                 extra_hour_price: 600, price_for_weekend: true, event_type: event_type)

            #Act
            result = event_price.valid?

            #Assert
            expect(result).to eq false
        end

        it 'falso quando valor por hora extra é nulo' do
            #Arrange
            user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
            buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", description: "Buffet para casamentos e festas de 15 anos", 
                                payment_methods: "Boleto e Cartão", user: user)
            event_type = EventType.create!(name: 'Halloween', description: 'Doces e deliciosas travessuras', min_guests: 50, max_guests: 500, 
                                duration_minutes: 300, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                parking_available: true, location_type: 'on_site', buffet: buffet)
                                event_price = EventPrice.new(base_price: 5000, additional_guest_price: 100, 
                                                                 extra_hour_price: nil, price_for_weekend: true, event_type: event_type)

            #Act
            result = event_price.valid?

            #Assert
            expect(result).to eq false
        end

    end

end
