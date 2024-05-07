require 'rails_helper'

describe 'Cade_buffet API' do

    context 'GET /api/v1/buffets' do

        it 'list all buffets' do
            #Arrange
            user_1 = User.create!(name: 'Patricia',  cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
            user_2 = User.create!(name: 'Victor', cpf: '98338378402', email: 'vitinho@gmail.com', password: 'vitor123', is_buffet_owner: true)
            method_1 = PaymentMethod.create!(name: "Boleto Bancário")
            method_2 = PaymentMethod.create!(name: "Cartão de Crédito")
            buffet_1 = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                    phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                    city: "Salvador", state: "Bahia", zip_code: "40527-700", 
                                    description: "Buffet para casamentos e festas de 15 anos", user: user_1)
            buffet_1.payment_methods << [method_1, method_2]
            buffet_2 = Buffet.create!(brand_name: "Vitinho do Buffet", corporate_name: "Vitinho do Buffet LTDA", registration_number: "251715366833", 
                                    phone: "55-89742994", email: "buffetviti@email.com", address: "Av contorno, 100", district: "Comércio", 
                                    city: "São Paulo", state: "SP", zip_code: "403647-460", 
                                    description: "Buffet para todas as horas!", user: user_2)
            buffet_2.payment_methods << [method_1, method_2]

            #Act
            get '/api/v1/buffets'

            #Assert
            expect(response.status).to eq 200
            expect(response.content_type).to include 'application/json'
            json_response = JSON.parse(response.body)
            expect(json_response.length).to eq 2
            expect(json_response[0]['brand_name']).to eq 'Patty Buffet'
            expect(json_response[1]['brand_name']).to eq 'Vitinho do Buffet'

        end

        it 'list buffets filtered by name' do
            # Arrange
            user_1 = User.create!(name: 'Patricia',  cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
            user_2 = User.create!(name: 'Victor', cpf: '98338378402', email: 'vitinho@gmail.com', password: 'vitor123', is_buffet_owner: true)
            method_1 = PaymentMethod.create!(name: "Boleto Bancário")
            method_2 = PaymentMethod.create!(name: "Cartão de Crédito")
            buffet_1 = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                    phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                    city: "Salvador", state: "Bahia", zip_code: "40527-700", 
                                    description: "Buffet para casamentos e festas de 15 anos", user: user_1)
            buffet_1.payment_methods << [method_1, method_2]
            buffet_2 = Buffet.create!(brand_name: "Vitinho do Buffet", corporate_name: "Vitinho do Buffet LTDA", registration_number: "251715366833", 
                                    phone: "55-89742994", email: "buffetviti@email.com", address: "Av contorno, 100", district: "Comércio", 
                                    city: "São Paulo", state: "SP", zip_code: "403647-460", 
                                    description: "Buffet para todas as horas!", user: user_2)
            buffet_2.payment_methods << [method_1, method_2]

            # Act
            get '/api/v1/buffets', params: { search: 'Patty' }

            # Assert
            expect(response.status).to eq 200
            expect(response.content_type).to include 'application/json'
            json_response = JSON.parse(response.body)
            expect(json_response.length).to eq 1
            expect(json_response[0]['brand_name']).to eq 'Patty Buffet'
        end

    end

    context 'GET /api/v1/buffets/:id' do

        it 'success' do
            #Arrange
            user = User.create!(name: 'Patricia',  cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
            method = PaymentMethod.create!(name: "Boleto Bancário")
            buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                    phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                    city: "Salvador", state: "Bahia", zip_code: "40527-700", 
                                    description: "Buffet para casamentos e festas de 15 anos", user: user)
            buffet.payment_methods << method

            #Act
            get "/api/v1/buffets/#{buffet.id}"

            #Assert 
            expect(response.status).to eq 200
            expect(response.content_type).to include 'application/json'
            json_response = JSON.parse(response.body)
            expect(json_response["brand_name"]).to eq('Patty Buffet')
            expect(json_response["state"]).to eq('Bahia')
            expect(json_response.keys).not_to include("corporate_name")
            expect(json_response.keys).not_to include("registration_number")
        end

    end

    context 'GET /api/v1/buffets/:buffet_id/event_types' do

        it 'success' do
            #Arrange
            user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
            method = PaymentMethod.create!(name: "Pix")
            buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                    phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                    city: "Salvador", state: "Bahia", zip_code: "40527-700", 
                                    description: "Buffet para casamentos e festas de 15 anos", user: user)
            buffet.payment_methods << method
            event_type_1 = EventType.create!(name: 'Halloween', description: 'Doces e deliciosas travessuras', min_guests: 50, max_guests: 500, 
                                    duration_minutes: 300, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                    parking_available: true, location_type: 'on_site', buffet: buffet)
            event_type_2 = EventType.create!(name: 'Casamento', description: 'Eternize o seu amor', min_guests: 200, max_guests: 1000, 
                                    duration_minutes: 400, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                    parking_available: true, location_type: 'off_site', buffet: buffet)
        
            #Act
            get "/api/v1/buffets/#{buffet.id}/event_types"

            #Assert
            expect(response.status).to eq 200
            expect(response.content_type).to include 'application/json'
            json_response = JSON.parse(response.body)
            expect(json_response.length).to eq 2
            expect(json_response[0]['name']).to eq 'Halloween'
            expect(json_response[1]['name']).to eq 'Casamento'

        end

    end

    context 'GET /api/v1/buffets/:buffet_id/event_types/:id/availability' do

        it 'success when the number of guests are valid and the date is available' do

            #Arrange
            user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
            method = PaymentMethod.create!(name: "Pix")
            buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                    phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                    city: "Salvador", state: "Bahia", zip_code: "40527-700", 
                                    description: "Buffet para casamentos e festas de 15 anos", user: user)
            buffet.payment_methods << method
            event_type = EventType.create!(name: 'Halloween', description: 'Doces e deliciosas travessuras', min_guests: 50, max_guests: 500, 
                                    duration_minutes: 300, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                    parking_available: true, location_type: 'on_site', buffet: buffet)
            event_price_1 = EventPrice.create!(base_price: 7000, additional_guest_price: 200, extra_hour_price: 600, price_for_weekend: true, event_type: event_type)
            event_price_2 = EventPrice.create!(base_price: 6000, additional_guest_price: 200, extra_hour_price: 600, price_for_weekend: false, event_type: event_type)

            #Act
            get "/api/v1/buffets/#{buffet.id}/event_types/#{event_type.id}/availability", params: {date: 1.month.from_now.strftime('%d/%m/%Y'), guests: 500}

            #Assert
            expect(response).to have_http_status(200)
            json_response = JSON.parse(response.body)
            expect(json_response['available']).to be true
            expect(json_response['estimated_price']).to be_present
            
        end

    end

end