require 'rails_helper'

describe 'Usuário vê avaliações de um buffet' do

    it 'e vê a nota média do buffet' do
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
        event_price_1 = EventPrice.create!(base_price: 7000, additional_guest_price: 200, extra_hour_price: 600, price_for_weekend: true, event_type: event_type)
        event_price_2 = EventPrice.create!(base_price: 4000, additional_guest_price: 200, extra_hour_price: 600, price_for_weekend: false, event_type: event_type)
        client_1 = User.create!(name: 'João', cpf: '75212608805', email: 'joao@email.com', password: 'joao123', is_buffet_owner: false)
        order_1 = Order.create!(buffet: buffet, user:client_1, event_type: event_type, number_of_guests: 150, 
                              event_date: 1.month.ago, details: 'Halloween fora de época',  payment_method: method_1, status: :confirmed)
        client_2 = User.create!(name: 'Ingrid', cpf: '64778827953', email: 'ingd@email.com', password: 'ingd123', is_buffet_owner: false)
        order_2 = Order.create!(buffet: buffet, user:client_2, event_type: event_type, number_of_guests: 150, 
                                event_date: 1.year.ago, details: 'Halloween da ingrid 2',  payment_method: method_1, status: :confirmed)
        review_1 = Review.create!(rating: 4, comment: "Foi excelente", buffet: buffet, user: client_1)
        review_2 = Review.create!(rating: 2, comment: "A comida estava fria e não gostei da decoração", buffet: buffet, user: client_2)

        #Arrange
        visit root_path
        click_on 'Patty Buffet'

        #Assert
        expect(page).to have_content 'Nota média: 3'
    end

    it 'e vê 3 avaliações' do
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
        event_price_1 = EventPrice.create!(base_price: 7000, additional_guest_price: 200, extra_hour_price: 600, price_for_weekend: true, event_type: event_type)
        event_price_2 = EventPrice.create!(base_price: 4000, additional_guest_price: 200, extra_hour_price: 600, price_for_weekend: false, event_type: event_type)
        client_1 = User.create!(name: 'João', cpf: '75212608805', email: 'joao@email.com', password: 'joao123', is_buffet_owner: false)
        order_1 = Order.create!(buffet: buffet, user:client_1, event_type: event_type, number_of_guests: 150, 
                              event_date: 1.month.ago, details: 'Halloween fora de época',  payment_method: method_1, status: :confirmed)
        client_2 = User.create!(name: 'Ingrid', cpf: '64778827953', email: 'ingd@email.com', password: 'ingd123', is_buffet_owner: false)
        order_2 = Order.create!(buffet: buffet, user:client_2, event_type: event_type, number_of_guests: 150, 
                                event_date: 1.year.ago, details: 'Halloween da ingrid 2',  payment_method: method_1, status: :confirmed)
        order_3 = Order.create!(buffet: buffet, user:client_2, event_type: event_type, number_of_guests: 150, 
                                event_date: 2.year.ago, details: 'Halloween da ingrid 1',  payment_method: method_1, status: :confirmed)
        review_1 = Review.create!(rating: 4, comment: "Foi excelente", buffet: buffet, user: client_1)
        review_2 = Review.create!(rating: 2, comment: "A comida estava fria e não gostei da decoração desse ano", buffet: buffet, user: client_2)
        review_3 = Review.create!(rating: 3, comment: "A comida estava boa!", buffet: buffet, user: client_2)

        #Arrange
        visit root_path
        click_on 'Patty Buffet'

        #Assert
        expect(page).to have_content 'Nota média: 3'
        expect(page).to have_content 'Foi excelente'
        expect(page).to have_content 'A comida estava fria e não gostei da decoração desse ano'
        expect(page).to have_content 'A comida estava boa!'
    end

    it 'e clica para ver mais avaliações' do
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
        event_price_1 = EventPrice.create!(base_price: 7000, additional_guest_price: 200, extra_hour_price: 600, price_for_weekend: true, event_type: event_type)
        event_price_2 = EventPrice.create!(base_price: 4000, additional_guest_price: 200, extra_hour_price: 600, price_for_weekend: false, event_type: event_type)
        client_1 = User.create!(name: 'João', cpf: '75212608805', email: 'joao@email.com', password: 'joao123', is_buffet_owner: false)
        order_1 = Order.create!(buffet: buffet, user:client_1, event_type: event_type, number_of_guests: 150, 
                              event_date: 1.month.ago, details: 'Halloween fora de época 2',  payment_method: method_1, status: :confirmed)
        client_2 = User.create!(name: 'Ingrid', cpf: '64778827953', email: 'ingd@email.com', password: 'ingd123', is_buffet_owner: false)
        order_2 = Order.create!(buffet: buffet, user:client_2, event_type: event_type, number_of_guests: 150, 
                                event_date: 1.year.ago, details: 'Halloween da ingrid 2',  payment_method: method_1, status: :confirmed)
        order_3 = Order.create!(buffet: buffet, user:client_2, event_type: event_type, number_of_guests: 150, 
                                event_date: 2.year.ago, details: 'Halloween da ingrid 1',  payment_method: method_1, status: :confirmed)
        order_4 = Order.create!(buffet: buffet, user:client_1, event_type: event_type, number_of_guests: 150, 
                                event_date: 2.month.ago, details: 'Halloween fora de época 1',  payment_method: method_1, status: :confirmed)
        review_1 = Review.create!(rating: 4, comment: "Foi excelente", buffet: buffet, user: client_1)
        review_2 = Review.create!(rating: 2, comment: "A comida estava fria e não gostei da decoração desse ano", buffet: buffet, user: client_2)
        review_3 = Review.create!(rating: 3, comment: "A comida estava boa!", buffet: buffet, user: client_2)
        review_4 = Review.create!(rating: 4, comment: "Foi muito bom, irei contratar de novo!", buffet: buffet, user: client_1)

        #Arrange
        visit root_path
        click_on 'Patty Buffet'
        click_on 'Ver mais avaliações'

        #Assert
        expect(page).to have_content "Avaliações sobre 'Patty Buffet'"
        expect(page).to have_content 'Foi excelente'
        expect(page).to have_content 'A comida estava fria e não gostei da decoração desse ano'
        expect(page).to have_content 'A comida estava boa!'
        expect(page).to have_content 'Foi muito bom, irei contratar de novo!'
    end

    it 'e não existem avaliações' do
        #Arrange 
        user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
        method_1 = PaymentMethod.create!(name: "Boleto Bancário")
        method_2 = PaymentMethod.create!(name: "Cartão de Crédito")
        buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", 
                                description: "Buffet para casamentos e festas de 15 anos", user: user)
        buffet.payment_methods << [method_1, method_2]
        

        #Arrange
        visit root_path
        click_on 'Patty Buffet'

        #Assert
        expect(page).to have_content "Avaliações do Buffet"
        expect(page).to have_content 'Ainda não existem avaliações.'
    end

end