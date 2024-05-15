require 'rails_helper'

describe 'Usuário dono de buffet atualiza tipo de evento' do

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
        click_on 'Atualizar tipo de evento'
        fill_in "Nome", with: "Casamento"
        fill_in "Descrição", with: "Temos o melhor buffet para casamentos."
        fill_in "Duração em minutos", with: '360' #Lembrete: Alterar no formulário para horas e depois implementar a lógica de conversão
        fill_in "Descrição do Menu", with: "Massas, carnes e sobremesas variadas"
        click_on 'Salvar'

        #Assert
        expect(current_path).to eq event_type_path(buffet.event_types.last)
        expect(page).to have_content("Casamento")
        expect(page).to have_content("Temos o melhor buffet para casamentos.")
        expect(page).to have_content("6 horas")
        expect(page).to have_content("Massas, carnes e sobremesas variadas")


    end

end