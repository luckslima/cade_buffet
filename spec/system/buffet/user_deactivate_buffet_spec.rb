require 'rails_helper'

describe 'Usuário Dono de Buffet desativa o buffet' do 

    it 'a partir da tela de detalhes do buffet' do 
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

        #Assert
        expect(page).to have_link "Desativar Buffet"
        expect(page).not_to have_link "Reativar Buffet"

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
        click_on "Desativar Buffet"

        #Assert
        expect(page).to have_content "Aviso: Este buffet se encontra inativo."
        expect(page).to have_link "Reativar Buffet"

    end

end