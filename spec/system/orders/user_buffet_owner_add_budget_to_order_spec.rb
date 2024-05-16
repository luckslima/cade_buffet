require 'rails_helper'

describe 'Usuário dono de buffet registra o orçamento do pedido' do 

    it 'a partir da tela de detalhes do pedido' do 
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
        click_on 'Gerar Orçamento'

        #Assert
        expect(current_path).to eq new_order_order_budget_path(order_id: order.id) 
        expect(page).to have_content 'Orçamento para o pedido'
        expect(page).to have_content 'Meio de Pagamento'
        expect(page).to have_content 'Desconto (R$)'
        expect(page).to have_content 'Taxa extra (R$)'
        expect(page).to have_content 'Observações'
        expect(page).to have_content 'Orçamento válido até'
        expect(page).to have_button 'Aprovar Pedido'


    end

    it 'e aprova o pedido com sucesso' do 
        #Arrange 
        user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
        method_1 = PaymentMethod.create!(name: "Boleto Bancário")
        method_2 = PaymentMethod.create!(name: "Pix")
        buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", 
                                description: "Buffet para casamentos e festas de 15 anos", user: user)
        buffet.payment_methods << [method_1, method_2]
        event_type = EventType.create!(name: 'Halloween', description: 'Doces e deliciosas travessuras', min_guests: 50, max_guests: 500, 
                                       duration_minutes: 300, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                       parking_available: true, location_type: 'on_site', buffet: buffet)
        event_price_1 = EventPrice.create!(base_price: 7000, additional_guest_price: 200, extra_hour_price: 600, price_for_weekend: true, event_type: event_type)
        event_price_2 = EventPrice.create!(base_price: 6000, additional_guest_price: 200, extra_hour_price: 600, price_for_weekend: false, event_type: event_type)
        client = User.create!(name: 'João', cpf: '75212608805', email: 'joao@email.com', password: 'joao123', is_buffet_owner: false)
        order = Order.create!(buffet: buffet, user:client, event_type: event_type, number_of_guests: 150, 
                              event_date: 1.month.from_now, details: 'Halloween fora de época', payment_method: method_2)

        #Act
        login_as(user)
        visit root_path
        within("#nav-pedidos") do
            click_on 'Pedidos'
        end
        click_on order.code
        click_on 'Gerar Orçamento'
        date = I18n.localize(1.month.from_now)
        fill_in 'Orçamento válido até', with: "12/12/2030"
        select "Pix", from: "Meio de Pagamento"
        fill_in 'Desconto (R$)', with: '359,99'
        fill_in 'Observações', with: "Desconto de cliente número 1"
        click_on "Aprovar Pedido"

        #Assert
        expect(current_path).to eq order_path(order.id) 
        expect(page).to have_content 'Orçamento registrado com sucesso, pedido aprovado!'
        expect(page).to have_content "Situação do pedido: Aprovado pelo Buffet"
        expect(page).to have_content 'Orçamento para o pedido:'
        expect(page).to have_content 'Taxa Extra: R$ 0,00'
        expect(page).to have_content 'Desconto: R$ 359,99'
        expect(page).to have_content 'Valor final:'
        expect(page).to have_content 'Observações: Desconto de cliente número 1'
        expect(page).to have_content 'Orçamento válido até: 12/12/2030'

    end

    it 'e deixa campos obrigatórios em branco' do 
        #Arrange 
        user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
        method_1 = PaymentMethod.create!(name: "Boleto Bancário")
        method_2 = PaymentMethod.create!(name: "Pix")
        buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", 
                                description: "Buffet para casamentos e festas de 15 anos", user: user)
        buffet.payment_methods << [method_1, method_2]
        event_type = EventType.create!(name: 'Halloween', description: 'Doces e deliciosas travessuras', min_guests: 50, max_guests: 500, 
                                       duration_minutes: 300, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                       parking_available: true, location_type: 'on_site', buffet: buffet)
        event_price_1 = EventPrice.create!(base_price: 7000, additional_guest_price: 200, extra_hour_price: 600, price_for_weekend: true, event_type: event_type)
        event_price_2 = EventPrice.create!(base_price: 6000, additional_guest_price: 200, extra_hour_price: 600, price_for_weekend: false, event_type: event_type)
        client = User.create!(name: 'João', cpf: '75212608805', email: 'joao@email.com', password: 'joao123', is_buffet_owner: false)
        order = Order.create!(buffet: buffet, user:client, event_type: event_type, number_of_guests: 150, 
                              event_date: 1.month.from_now, details: 'Halloween fora de época', payment_method: method_2)

        #Act
        login_as(user)
        visit root_path
        within("#nav-pedidos") do
            click_on 'Pedidos'
        end
        click_on order.code
        click_on 'Gerar Orçamento'
        date = I18n.localize(1.month.from_now)
        fill_in 'Orçamento válido até', with: ""
        select "Pix", from: "Meio de Pagamento"
        fill_in 'Desconto (R$)', with: '359,99'
        fill_in 'Observações', with: "Desconto de cliente número 1"
        click_on "Aprovar Pedido"

        #Assert
        expect(page).not_to have_content 'Orçamento registrado com sucesso, pedido aprovado!'
        expect(page).to have_content "Não foi possível aprovar o pedido."

    end

end