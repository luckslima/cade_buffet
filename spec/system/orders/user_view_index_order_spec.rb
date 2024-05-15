require 'rails_helper'

describe 'Usuário vê pedidos' do

    context 'como cliente' do

        it 'com sucesso' do
            #Arrange 
            user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
            method_1 = PaymentMethod.create!(name: "Boleto Bancário")
            method_2 = PaymentMethod.create!(name: "Cartão de Crédito")
            buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                    phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                    city: "Salvador", state: "Bahia", zip_code: "40527-700", 
                                    description: "Buffet para casamentos e festas de 15 anos", user: user)
            buffet.payment_methods << [method_1, method_2]
            event_type = EventType.create!(name: 'Halloween', description: 'Doces e deliciosas travessuras', min_guests: 50, max_guests: 500, 
                                           duration_minutes: 300, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                           parking_available: true, location_type: 'on_site', buffet: buffet)
            event_price = EventPrice.create!(base_price: 7000, additional_guest_price: 200, extra_hour_price: 600, price_for_weekend: true, event_type: event_type)
            client = User.create!(name: 'João', cpf: '75212608805', email: 'joao@email.com', password: 'joao123', is_buffet_owner: false)
            order = Order.create!(buffet: buffet, user:client, event_type: event_type, number_of_guests: 150, 
                                  event_date: 1.month.from_now, details: 'Halloween fora de época',  payment_method: method_1)
    
            #Act
            login_as(client)
            visit root_path
            within("#nav-meus-pedidos") do
                click_on 'Meus Pedidos'
            end
    
            #Assert
            expect(current_path).to eq orders_path
            expect(page).to have_content order.code
            expect(page).to have_content "Buffet: Patty Buffet"
            expect(page).to have_content "Evento: Halloween"
            formatted_date = I18n.localize(1.month.from_now.to_date)
            expect(page).to have_content "Data: #{formatted_date}"
            expect(page).to have_content "Status: Aguardando avaliação do buffet"
    
        end

        it 'e não vê pedidos de outros usuários' do 
            #Arrange 
            user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
            method_1 = PaymentMethod.create!(name: "Boleto Bancário")
            method_2 = PaymentMethod.create!(name: "Cartão de Crédito")
            buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                    phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                    city: "Salvador", state: "Bahia", zip_code: "40527-700", 
                                    description: "Buffet para casamentos e festas de 15 anos", user: user)
            buffet.payment_methods << [method_1, method_2]
            event_type = EventType.create!(name: 'Halloween', description: 'Doces e deliciosas travessuras', min_guests: 50, max_guests: 500, 
                                           duration_minutes: 300, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                           parking_available: true, location_type: 'on_site', buffet: buffet)
            event_price = EventPrice.create!(base_price: 7000, additional_guest_price: 200, extra_hour_price: 600, price_for_weekend: true, event_type: event_type)
            client_1 = User.create!(name: 'João', cpf: '75212608805', email: 'joao@email.com', password: 'joao123', is_buffet_owner: false)
            client_2 = User.create!(name: 'Maria', cpf: '51581985274', email: 'maria@email.com', password: 'maria123', is_buffet_owner: false)
            order_1 = Order.create!(buffet: buffet, user:client_1, event_type: event_type, number_of_guests: 150, 
                                  event_date: 1.month.from_now, details: 'Halloween fora de época',  payment_method: method_1)
            order_2 = Order.create!(buffet: buffet, user:client_2, event_type: event_type, number_of_guests: 300, 
                                  event_date: 1.week.from_now, details: 'Halloween da terceira idade',  payment_method: method_2)
    
            #Act
            login_as(client_1)
            visit root_path
            within("#nav-meus-pedidos") do    
                click_on 'Meus Pedidos'
            end

            #Assert
            expect(page).to have_content order_1.code
            formatted_date_1 = I18n.localize(1.month.from_now.to_date)
            expect(page).to have_content "Data: #{formatted_date_1}"
            expect(page).not_to have_content order_2.code
            formatted_date_2 = I18n.localize(1.week.from_now.to_date)
            expect(page).not_to have_content "Data: #{formatted_date_2}"


        end

        it 'e não existem pedidos cadastrados' do
            #Arrange 
            user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
            method_1 = PaymentMethod.create!(name: "Boleto Bancário")
            method_2 = PaymentMethod.create!(name: "Cartão de Crédito")
            buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                    phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                    city: "Salvador", state: "Bahia", zip_code: "40527-700", 
                                    description: "Buffet para casamentos e festas de 15 anos", user: user)
            buffet.payment_methods << [method_1, method_2]
            event_type = EventType.create!(name: 'Halloween', description: 'Doces e deliciosas travessuras', min_guests: 50, max_guests: 500, 
                                           duration_minutes: 300, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                           parking_available: true, location_type: 'on_site', buffet: buffet)
            event_price = EventPrice.create!(base_price: 7000, additional_guest_price: 200, extra_hour_price: 600, price_for_weekend: true, event_type: event_type)
            client = User.create!(name: 'João', cpf: '75212608805', email: 'joao@email.com', password: 'joao123', is_buffet_owner: false)
    
            #Act
            login_as(client)
            visit root_path
            within("#nav-meus-pedidos") do
                click_on 'Meus Pedidos'
            end

            #Assert
            expect(page).to have_content "Não há pedidos para mostrar."

        end

    end

    context 'como dono de buffet' do

        it 'com sucesso' do
            #Arrange 
            user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
            method_1 = PaymentMethod.create!(name: "Boleto Bancário")
            method_2 = PaymentMethod.create!(name: "Cartão de Crédito")
            buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                    phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                    city: "Salvador", state: "Bahia", zip_code: "40527-700", 
                                    description: "Buffet para casamentos e festas de 15 anos", user: user)
            buffet.payment_methods << [method_1, method_2]
            event_type = EventType.create!(name: 'Halloween', description: 'Doces e deliciosas travessuras', min_guests: 50, max_guests: 500, 
                                           duration_minutes: 300, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                           parking_available: true, location_type: 'on_site', buffet: buffet)
            event_price = EventPrice.create!(base_price: 7000, additional_guest_price: 200, extra_hour_price: 600, price_for_weekend: true, event_type: event_type)
            client = User.create!(name: 'João', cpf: '75212608805', email: 'joao@email.com', password: 'joao123', is_buffet_owner: false)
            order = Order.create!(buffet: buffet, user:client, event_type: event_type, number_of_guests: 150, 
                                  event_date: 1.month.from_now, details: 'Halloween fora de época', payment_method: method_1)
    
            #Act
            login_as(user)
            visit root_path
            within("#nav-pedidos") do
                click_on 'Pedidos'
            end
    
            #Assert
            expect(current_path).to eq orders_path
            expect(page).to have_content "Pedidos Pendentes"
            expect(page).to have_content order.code
            expect(page).to have_content "Evento: Halloween"
            formatted_date = I18n.localize(1.month.from_now.to_date)
            expect(page).to have_content "Data: #{formatted_date}"
            expect(page).to have_content "Outros Pedidos"
            expect(page).to have_content "Não há outros pedidos."
    
        end

        it 'e não existem pedidos para o buffet' do
            #Arrange 
            user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
            method_1 = PaymentMethod.create!(name: "Boleto Bancário")
            method_2 = PaymentMethod.create!(name: "Cartão de Crédito")
            buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                    phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                    city: "Salvador", state: "Bahia", zip_code: "40527-700", 
                                    description: "Buffet para casamentos e festas de 15 anos", user: user)
            buffet.payment_methods << [method_1, method_2]
            event_type = EventType.create!(name: 'Halloween', description: 'Doces e deliciosas travessuras', min_guests: 50, max_guests: 500, 
                                           duration_minutes: 300, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                           parking_available: true, location_type: 'on_site', buffet: buffet)
            event_price = EventPrice.create!(base_price: 7000, additional_guest_price: 200, extra_hour_price: 600, price_for_weekend: true, event_type: event_type)
    
            #Act
            login_as(user)
            visit root_path
            within("#nav-pedidos") do
                click_on 'Pedidos'
            end

            #Assert
            expect(page).to have_content "Não há pedidos pendentes."
            expect(page).to have_content "Não há outros pedidos."

        end

        
    end



end