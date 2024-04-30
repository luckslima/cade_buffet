require 'rails_helper'

describe 'Usuário Dono de Buffet vê detalhes de um pedido' do 

    it 'e é sinalizado de que existe outro pedido para a mesma data' do 
        #Arrange
        user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
        buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", description: "Buffet para casamentos e festas de 15 anos", 
                                payment_methods: "Boleto e Cartão", user: user)
        event_type = EventType.create!(name: 'Halloween', description: 'Doces e deliciosas travessuras', min_guests: 50, max_guests: 500, 
                                       duration_minutes: 300, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                       parking_available: true, location_type: 'on_site', buffet: buffet)
        client_1 = User.create!(name: 'João', cpf: '75212608805', email: 'joao@email.com', password: 'joao123', is_buffet_owner: false)
        order_1 = Order.create!(buffet: buffet, user:client_1, event_type: event_type, number_of_guests: 150, 
                              event_date: 1.month.from_now, details: 'Halloween fora de época')
        client_2 = User.create!(name: 'Maria', cpf: '14458068199', email: 'maria@email.com', password: 'maria123', is_buffet_owner: false)
        order_2 = Order.create!(buffet: buffet, user:client_2, event_type: event_type, number_of_guests: 250, 
                              event_date: 1.month.from_now, details: 'Halloween para crianças')

        #Act
        login_as(user)
        visit root_path
        click_on 'Pedidos'
        click_on order_1.code

        #Assert
        expect(current_path).to eq order_path(order_1.id)
        expect(page).to have_content 'Aviso: Existem outros pedidos para a mesma data.'


    end

end