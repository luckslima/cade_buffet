require 'rails_helper'

describe 'Usuário Dono de Buffet desativa o tipo de evento' do 

    it 'a partir da tela de detalhes do tipo de evento' do 
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

        #Assert
        expect(page).to have_link "Desativar tipo de evento"
        expect(page).not_to have_link "Reativar tipo de evento"

    end

    it 'com sucesso' do 
        #Arrange
        user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
        method = PaymentMethod.create!(name: "Pix")
        buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", 
                                description: "Buffet para casamentos e festas de 15 anos", user: user)
        buffet.payment_methods << method

        #Act
        login_as(user)
        visit root_path
        within("#nav-meu-buffet") do
            click_on 'Meu buffet'
        end
        click_on 'Halloween'
        click_on 'Desativar tipo de evento'

        #Assert
        expect(page).to have_content "Aviso: Esse tipo de evento não é mais realizado."
        expect(page).to have_link "Reativar tipo de evento"

    end

end