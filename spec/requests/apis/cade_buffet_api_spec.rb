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

        it 'only list buffets activated' do
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
                                    description: "Buffet para todas as horas!", user: user_2, status: :inactive)
            buffet_2.payment_methods << [method_1, method_2]

            #Act
            get '/api/v1/buffets'

            #Assert
            expect(response.status).to eq 200
            expect(response.content_type).to include 'application/json'
            json_response = JSON.parse(response.body)
            expect(json_response.length).to eq 1
            expect(json_response[0]['brand_name']).to eq 'Patty Buffet'

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

        it 'list buffets filtered by name but ony the activated ones' do
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
                                    description: "Buffet para todas as horas!", user: user_2, status: :inactive)
            buffet_2.payment_methods << [method_1, method_2]

            # Act
            get '/api/v1/buffets', params: { search: 'buffet' }

            # Assert
            expect(response.status).to eq 200
            expect(response.content_type).to include 'application/json'
            json_response = JSON.parse(response.body)
            expect(json_response.length).to eq 1
            expect(json_response[0]['brand_name']).to eq 'Patty Buffet'
        end

        it 'return empty if there is no buffets' do
            #Arrange

             #Act
             get "/api/v1/buffets"

             #Assert
             expect(response.status).to eq 200
             expect(response.content_type).to include 'application/json'
             json_response = JSON.parse(response.body)
             expect(json_response.length).to eq 0

        end

        it 'and raise an internal error' do
            #Arrange
            allow(Buffet).to receive(:all).and_raise(ActiveRecord::ActiveRecordError)

            #Act
            get "/api/v1/buffets"


            #Assert
            expect(response).to have_http_status(500)

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

        it 'fail if buffet not found' do
            #Arrange
    
            #Act
            get "/api/v1/buffets/999999999"
    
            #Act
            expect(response.status).to eq 404
    
        end

    end

    context 'GET /api/v1/buffets/:buffet_id/event_types' do

        it 'list event types from a buffet' do
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

        it 'list only event types activated from a buffet' do
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
                                    parking_available: true, location_type: 'off_site', buffet: buffet, status: :inactive)
        
            #Act
            get "/api/v1/buffets/#{buffet.id}/event_types"

            #Assert
            expect(response.status).to eq 200
            expect(response.content_type).to include 'application/json'
            json_response = JSON.parse(response.body)
            expect(json_response.length).to eq 1
            expect(json_response[0]['name']).to eq 'Halloween'

        end

        it 'return empty if there are no event types' do
            #Arrange
            user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
            method = PaymentMethod.create!(name: "Pix")
            buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                    phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                    city: "Salvador", state: "Bahia", zip_code: "40527-700", 
                                    description: "Buffet para casamentos e festas de 15 anos", user: user)
            buffet.payment_methods << method

            #Act
            get "/api/v1/buffets/#{buffet.id}/event_types"

            #Assert
            expect(response.status).to eq 200
            expect(response.content_type).to include 'application/json'
            json_response = JSON.parse(response.body)
            expect(json_response.length).to eq 0

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
            get "/api/v1/buffets/#{buffet.id}/event_types/#{event_type.id}/availability", params: {date: 1.month.from_now , guests: 500}

            #Assert
            expect(response).to have_http_status(200)
            json_response = JSON.parse(response.body)
            expect(json_response['available']).to be true
            expect(json_response['estimated_price']).to be_present
            
        end

        it 'returns error when the number of guests is less than the minimum allowed' do
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
            get "/api/v1/buffets/#{buffet.id}/event_types/#{event_type.id}/availability", params: {date: 1.month.from_now , guests: 49}

            #Assert
            expect(response).to have_http_status(406)
            json_response = JSON.parse(response.body)
            expect(json_response['error']).to include('Quantidade de convidados fora do limite permitido')
        end

        it 'returns error when the date is already booked for another approved event' do
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
            client = User.create!(name: 'João', cpf: '75212608805', email: 'joao@email.com', password: 'joao123', is_buffet_owner: false)
            order = Order.create!(buffet: buffet, user:client, event_type: event_type, number_of_guests: 150, 
                                  event_date: 1.month.from_now, details: 'Halloween fora de época', payment_method: method, status: :approved)

            #Act
            get "/api/v1/buffets/#{buffet.id}/event_types/#{event_type.id}/availability", params: {date: 1.month.from_now , guests: 100}

            #Assert
            expect(response).to have_http_status(406)
            json_response = JSON.parse(response.body)
            expect(json_response['error']).to include('Não há disponibilidade para a data escolhida')
        end

        it 'returns error when the date is already booked for another confirmed event' do
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
            client = User.create!(name: 'João', cpf: '75212608805', email: 'joao@email.com', password: 'joao123', is_buffet_owner: false)
            order = Order.create!(buffet: buffet, user:client, event_type: event_type, number_of_guests: 150, 
                                  event_date: 1.month.from_now, details: 'Halloween fora de época', payment_method: method, status: :confirmed)

            #Act
            get "/api/v1/buffets/#{buffet.id}/event_types/#{event_type.id}/availability", params: {date: 1.month.from_now, guests: 100}

            #Assert
            expect(response).to have_http_status(406)
            json_response = JSON.parse(response.body)
            expect(json_response['error']).to include('Não há disponibilidade para a data escolhida')
        end

        it 'returns error for invalid date format' do
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

            # Act
            get "/api/v1/buffets/#{buffet.id}/event_types/#{event_type.id}/availability", params: { date: 'amajxaan', guests: 100 }
      
            # Assert
            expect(response).to have_http_status(400)
            json_response = JSON.parse(response.body)
            expect(json_response['error']).to include('Formato de data inválido')
        end

    end

end