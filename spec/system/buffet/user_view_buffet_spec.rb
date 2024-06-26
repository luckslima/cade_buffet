require 'rails_helper'

describe 'Usuário visitante vê Buffets cadastrados' do

    it 'a partir da tela inicial' do
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
        visit root_path

        #Assert
        expect(page).to have_content 'Patty Buffet'
        expect(page).to have_content 'Salvador | Bahia'
        expect(page).to have_content 'Vitinho do Buffet'
        expect(page).to have_content 'São Paulo | SP'

    end

    it 'e clica num buffet para ver detalhes' do

        #Arrange
        user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
        method_1 = PaymentMethod.create!(name: "Boleto Bancário")
        buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", 
                                description: "Buffet para casamentos e festas de 15 anos", user: user)
        buffet.payment_methods << method_1
        event_type = EventType.create!(name: 'Halloween', description: 'Doces e deliciosas travessuras', min_guests: 50, max_guests: 500, 
                                duration_minutes: 300, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                parking_available: true, location_type: 'on_site', buffet: buffet)

        #Act
        visit root_path
        click_on 'Patty Buffet'

        #Assert
        expect(current_path).to eq buffet_path(buffet.id)
        expect(page).to have_content 'Patty Buffet'
        expect(page).not_to have_content 'Patty Buffet LTDA'
        expect(page).to have_content '71-85642014'
        expect(page).to have_content 'pattybuffet@email.com'
        expect(page).to have_content 'Av oceânica, 100'
        expect(page).to have_content 'Halloween'

    end

    it 'e não vê buffets desativados' do
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
        visit root_path

        #Assert
        expect(page).to have_content 'Patty Buffet'
        expect(page).to have_content 'Salvador | Bahia'
        expect(page).not_to have_content 'Vitinho do Buffet'
        expect(page).not_to have_content 'São Paulo | SP'

    end

end