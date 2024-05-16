require 'rails_helper'

describe 'Usuário autenticado envia mensagem' do

    it 'com sucesso' do
        #Arrange 
        user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
        method = PaymentMethod.create!(name: "Boleto Bancário")
        buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", 
                                description: "Buffet para casamentos e festas de 15 anos", user: user)
        buffet.payment_methods << method
        event_type = EventType.create!(name: 'Halloween', description: 'Doces e deliciosas travessuras', min_guests: 50, max_guests: 500, 
                                       duration_minutes: 300, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                       parking_available: true, location_type: 'on_site', buffet: buffet)
        event_price = EventPrice.create!(base_price: 7000, additional_guest_price: 200, extra_hour_price: 600, price_for_weekend: true, event_type: event_type)
        event_price = EventPrice.create!(base_price: 6000, additional_guest_price: 200, extra_hour_price: 600, price_for_weekend: false, event_type: event_type)
        client = User.create!(name: 'João', cpf: '75212608805', email: 'joao@email.com', password: 'joao123', is_buffet_owner: false)
        order = Order.create!(buffet: buffet, user:client, event_type: event_type, number_of_guests: 150, 
                              event_date: 1.month.from_now, details: 'Halloween fora de época', payment_method: method)

        #Act
        login_as(user)
        visit root_path
        within("#nav-pedidos") do
            click_on 'Pedidos'
        end
        click_on order.code
        fill_in 'Nova Mensagem:', with: 'Oi, tudo bem?'
        click_on 'Enviar'

        #Assert
        expect(page).to have_content 'Mensagem enviada com sucesso.'
        expect(page).to have_content 'Oi, tudo bem?'

    end

    it 'e deixa a mensagem em branco' do
        #Arrange 
        user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
        method = PaymentMethod.create!(name: "Boleto Bancário")
        buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", 
                                description: "Buffet para casamentos e festas de 15 anos", user: user)
        buffet.payment_methods << method
        event_type = EventType.create!(name: 'Halloween', description: 'Doces e deliciosas travessuras', min_guests: 50, max_guests: 500, 
                                       duration_minutes: 300, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                       parking_available: true, location_type: 'on_site', buffet: buffet)
        event_price = EventPrice.create!(base_price: 7000, additional_guest_price: 200, extra_hour_price: 600, price_for_weekend: true, event_type: event_type)
        event_price = EventPrice.create!(base_price: 6000, additional_guest_price: 200, extra_hour_price: 600, price_for_weekend: false, event_type: event_type)
        client = User.create!(name: 'João', cpf: '75212608805', email: 'joao@email.com', password: 'joao123', is_buffet_owner: false)
        order = Order.create!(buffet: buffet, user:client, event_type: event_type, number_of_guests: 150, 
                              event_date: 1.month.from_now, details: 'Halloween fora de época', payment_method: method)

        #Act
        login_as(user)
        visit root_path
        within("#nav-pedidos") do
            click_on 'Pedidos'
        end
        click_on order.code
        fill_in 'Nova Mensagem:', with: ''
        click_on 'Enviar'

        #Assert
        expect(page).not_to have_content 'Mensagem enviada com sucesso.'
        expect(page).to have_content 'Não foi possível enviar a mensagem.'

    end

end