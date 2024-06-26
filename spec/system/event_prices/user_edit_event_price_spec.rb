require 'rails_helper'

describe 'Usuário atualiza um preço de um evento' do

    it 'com sucesso' do
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
        event_price = EventPrice.create!(base_price: 7000, additional_guest_price: 200, extra_hour_price: 600, price_for_weekend: true, event_type: event_type)

        #Act
        login_as(user)
        visit root_path
        within("#nav-meu-buffet") do
            click_on "Meu buffet"
        end
        click_on 'Halloween'
        click_on 'Atualizar preço'
        fill_in 'Preço base', with: '5000'
        fill_in 'Valor por hora extra', with: '500'
        uncheck 'Preço para final de semana'
        click_on 'Salvar'

        #Assert
        expect(current_path).to eq event_type_path(event_type)
        expect(page).to have_content('Preços atualizados com sucesso.')
        expect(page).to have_content('Preço base: R$ 5000')
        expect(page).to have_content('Valor por hora extra: R$ 500')
        expect(page).to have_content('Preço para dias de semana')

    end

    it 'e deixa dados incompletos' do
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
        event_price = EventPrice.create!(base_price: 7000, additional_guest_price: 200, extra_hour_price: 600, price_for_weekend: true, event_type: event_type)

        #Act
        login_as(user)
        visit root_path
        within("#nav-meu-buffet") do
            click_on "Meu buffet"
        end
        click_on 'Halloween'
        click_on 'Atualizar preço'
        fill_in 'Preço base', with: ''
        fill_in 'Valor por hora extra', with: ''
        uncheck 'Preço para final de semana'
        click_on 'Salvar'

        #Assert
        expect(page).not_to have_content('Preços atualizados com sucesso.')
        expect(page).to have_content('Não foi possível atualizar o preço do tipo de evento')
        

    end

end