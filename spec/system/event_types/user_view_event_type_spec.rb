require 'rails_helper'

describe 'Usuário visitante vê detalhes de tipo de evento' do 

    it 'a partir de uma página de um buffet' do
        #Arrange
        user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
        buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", description: "Buffet para casamentos e festas de 15 anos", 
                                payment_methods: "Boleto e Cartão", user: user)
        event_type = EventType.create!(name: 'Halloween', description: 'Doces e deliciosas travessuras', min_guests: 50, max_guests: 500, 
                                duration_minutes: 300, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                parking_available: true, location_type: 'on_site', buffet: buffet)
        event_price = EventPrice.create!(base_price: 7000, additional_guest_price: 200, extra_hour_price: 600, 
                                         price_for_weekend: true, event_type: event_type)

        #Act
        visit root_path
        click_on 'Patty Buffet'
        click_on 'Halloween'

        #Assert 
        expect(current_path).to eq event_type_path(event_type.id)
        expect(page).to have_content 'Doces e deliciosas travessuras'
        expect(page).to have_content "Mínimo: 50 convidados | Máximo: 500 convidados"
        expect(page).to have_content 'Massas, saladas e Sobremesas'
        expect(page).to have_content 'Preços'
        expect(page).to have_content 'Preço para final de semana'
        expect(page).to have_content 'Preço base: R$ 7000'
        expect(page).to have_content 'Valor adicional por pessoa: R$ 200'
        expect(page).to have_content 'Valor por hora extra: R$ 600'


    end

end