require 'rails_helper'

describe 'Usuário cliente cria um pedido' do

    it 'a partir de uma página de tipo de evento de um buffet' do
        #Arrange
        user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
        method_1 = PaymentMethod.create!(name: "Boleto Bancário")
        method_2 = PaymentMethod.create!(name: "Cartão de Crédito")
        buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", description: "Buffet para casamentos e festas de 15 anos", user: user)
        buffet.payment_methods << [method_1, method_2]
        event_type = EventType.create!(name: 'Halloween', description: 'Doces e deliciosas travessuras', min_guests: 50, max_guests: 500, 
                                       duration_minutes: 300, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                       parking_available: true, location_type: 'off_site', buffet: buffet)
        event_price = EventPrice.create!(base_price: 7000, additional_guest_price: 200, extra_hour_price: 600, price_for_weekend: true, event_type: event_type)
        client = User.create!(name: 'João', cpf: '75212608805', email: 'joao@email.com', password: 'joao123', is_buffet_owner: false)
        
        #Act
        login_as(client)
        visit root_path
        click_on "Patty Buffet"
        click_on "Halloween"
        click_on "Criar Pedido para evento"

        #Assert
        expect(current_path).to eq new_event_type_order_path(event_type)
        expect(page).to have_content "Criando um Pedido"
        expect(page).to have_content "Data do evento"
        expect(page).to have_content "Número estimado de convidados"
        expect(page).to have_content "Endereço do evento"
        expect(page).to have_content "Mais detalhes"
        expect(page).to have_content "Endereço do evento"    

    end

    it 'com sucesso' do
        #Arrange
        user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
        method_1 = PaymentMethod.create!(name: "Boleto Bancário")
        method_2 = PaymentMethod.create!(name: "Cartão de Crédito")
        buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", description: "Buffet para casamentos e festas de 15 anos", user: user)
        buffet.payment_methods << [method_1, method_2]
        event_type = EventType.create!(name: 'Halloween', description: 'Doces e deliciosas travessuras', min_guests: 50, max_guests: 500, 
                                       duration_minutes: 300, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                       parking_available: true, location_type: 'off_site', buffet: buffet)
        event_price = EventPrice.create!(base_price: 7000, additional_guest_price: 200, extra_hour_price: 600, price_for_weekend: true, event_type: event_type)
        client = User.create!(name: 'João', cpf: '75212608805', email: 'joao@email.com', password: 'joao123', is_buffet_owner: false)

        allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
        
        #Act
        login_as(client)
        visit new_event_type_order_path(event_type)
        fill_in "Data do evento", with: "31/10/2028"
        fill_in "Número estimado de convidados", with: 200
        fill_in "Endereço do evento", with: "Av. Contorno, 71, Comércio, Salvador - Bahia."
        fill_in "Mais detalhes", with: "Evento para a terceira idade com tema tropical"
        select "Cartão de Crédito", from: 'Método de Pagamento'
        click_on "Criar Pedido"

        #Assert
        expect(page).to have_content "Pedido criado com sucesso, aguarde a aprovaçao do Buffet!"
        expect(page).to have_content "Detalhes do Pedido 'ABC12345'"
        expect(page).to have_content "Tipo de evento: Halloween"
        expect(page).to have_content "Data do evento: 31/10/2028"
        expect(page).to have_content "Número estimado de convidados: 200"
        expect(page).to have_content "Endereço do evento: Av. Contorno, 71, Comércio, Salvador - Bahia."
        expect(page).to have_content "Mais detalhes: Evento para a terceira idade com tema tropical"
        expect(page).to have_content "Situação do pedido: Aguardando avaliação do buffet"
        
    end

    it 'e deixa campos obrigatórios incompletos' do
        #Arrange
        user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
        method_1 = PaymentMethod.create!(name: "Boleto Bancário")
        method_2 = PaymentMethod.create!(name: "Cartão de Crédito")
        buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", description: "Buffet para casamentos e festas de 15 anos", user: user)
        buffet.payment_methods << [method_1, method_2]
        event_type = EventType.create!(name: 'Halloween', description: 'Doces e deliciosas travessuras', min_guests: 50, max_guests: 500, 
                                       duration_minutes: 300, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                       parking_available: true, location_type: 'off_site', buffet: buffet)
        event_price = EventPrice.create!(base_price: 7000, additional_guest_price: 200, extra_hour_price: 600, price_for_weekend: true, event_type: event_type)
        client = User.create!(name: 'João', cpf: '75212608805', email: 'joao@email.com', password: 'joao123', is_buffet_owner: false)

        allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')
        
        #Act
        login_as(client)
        visit new_event_type_order_path(event_type)
        fill_in "Data do evento", with: ""
        fill_in "Número estimado de convidados", with: ""
        fill_in "Endereço do evento", with: "Av. Contorno, 71, Comércio, Salvador - Bahia."
        fill_in "Mais detalhes", with: "Evento para a terceira idade com tema tropical"
        select "Cartão de Crédito", from: 'Método de Pagamento'
        click_on "Criar Pedido"

        #Assert
        expect(page).not_to have_content "Pedido criado com sucesso, aguarde a aprovaçao do Buffet!"
        expect(page).not_to have_content "Detalhes do Pedido 'ABC12345'"
        expect(page).to have_content "Não foi possível criar pedido."
                
    end

end