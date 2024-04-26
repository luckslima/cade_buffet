require 'rails_helper'

describe 'Usuário visualiza seu buffet' do

    it 'com sucesso' do
        #Arrange
        user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
        buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", description: "Buffet para casamentos e festas de 15 anos", 
                                payment_methods: "Boleto e Cartão", user: user)

        #Act
        login_as(user)
        visit root_path
        click_on 'Meu buffet'

        #Assert
        expect(current_path).to eq buffet_path(user.buffet)
        expect(page).to have_content 'Patty Buffet'
        expect(page).to have_content 'Patty Buffet LTDA'
        expect(page).to have_content '1254783654'
        expect(page).to have_content 'Salvador | Bahia'
        expect(page).to have_content '40527-700'


    end

end