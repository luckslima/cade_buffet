require 'rails_helper'

describe 'Usuário cadastrado como dono de buffet registra um preço de tipo de evento' do
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

        #Act
        login_as(user)
        visit root_path
        within("#nav-meu-buffet") do
            click_on 'Meu buffet'
        end
        click_on 'Halloween'
        click_on 'Cadastrar preço para evento'
        fill_in 'Preço base', with: '5000'
        fill_in 'Valor adicional por pessoa', with: '100'
        fill_in 'Valor por hora extra', with: '500'
        check 'Preço para final de semana'
        click_on 'Salvar'

        #Assert
        expect(page).to have_content('Preços registrados com sucesso.')
        expect(page).to have_content('Preço base: R$ 5000')
        expect(page).to have_content('Valor adicional por pessoa: R$ 100')
        expect(page).to have_content('Valor por hora extra: R$ 500')
        expect(page).to have_content('Preço para final de semana')

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

        #Act
        login_as(user)
        visit root_path
        within("#nav-meu-buffet") do
            click_on 'Meu buffet'
        end
        click_on 'Halloween'
        click_on 'Cadastrar preço para evento'
        fill_in 'Preço base', with: ""
        fill_in 'Valor adicional por pessoa', with: '100'
        fill_in 'Valor por hora extra', with: ""
        check 'Preço para final de semana'
        click_on 'Salvar'

        #Assert
        expect(page).not_to have_content('Preços atualizados com sucesso.')
        expect(page).to have_content('Não foi possível registrar o preço.')

    end
end