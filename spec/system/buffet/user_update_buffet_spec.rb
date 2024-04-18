require "rails_helper"

describe 'Usuário atualiza um buffet' do 
    it 'com sucesso' do
        #Arrange
        user = User.create!(name: 'Patricia', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
        buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", description: "Buffet para casamentos e festas de 15 anos", 
                                payment_methods: "Boleto e Cartão", user: user)

        #Act
        login_as(user)
        visit root_path
        click_on 'Meu buffet'
        click_on 'Atualizar Buffet'
        fill_in "Nome Fantasia", with: "Buffet da Patty"
        fill_in "CEP", with: "40324-500" 
        click_on 'Atualizar Buffet'
                
        #Assert 
        expect(page).to have_content("Buffet atualizado com sucesso!")
        expect(page).to have_content("Buffet da Patty")
        expect(page).to have_content("40324-500")

    end

    it 'e a ação é negada' do
        #Arrange
        user_1 = User.create!(name: 'Patricia', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
        buffet_1 = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", description: "Buffet para casamentos e festas de 15 anos", 
                                payment_methods: "Boleto e Cartão", user: user_1)
        user_2 = User.create!(name: 'Victor', email: 'vitinho@gmail.com', password: 'vitor123', is_buffet_owner: true)
        buffet_2 = Buffet.create!(brand_name: "Vitinho do Buffet", corporate_name: "Vitinho do Buffet LTDA", registration_number: "251715366833", 
                                phone: "71-89742994", email: "buffetviti@email.com", address: "Av contorno, 100", district: "Comércio", 
                                city: "Salvador", state: "Bahia", zip_code: "403647-460", description: "Buffet para todas as horas!", 
                                payment_methods: "Boleto e Cartão", user: user_2)
        #Act
        login_as(user_2)
        visit edit_buffet_path(buffet_1)
        
        #Assert
        expect(page).to have_content("Você não tem permissão para editar esse buffet.")
    
    end
end