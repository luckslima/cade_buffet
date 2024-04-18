require 'rails_helper'

describe 'Usuário dono de buffet cadastra tipo de evento' do

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
        click_on 'Cadastrar tipo de evento'
        fill_in "Nome", with: "Casamento"
        fill_in "Descrição", with: "Temos o melhor buffet para casamentos."
        fill_in "Quantidade mínima de convidados", with: '50'
        fill_in "Quantidade máxima de convidados", with: '500'
        fill_in "Duração em minutos", with: 5 #Lembrete: Alterar no formulário para horas e depois implementar a lógica de conversão
        fill_in "Descrição do Menu", with: "Massas, carnes e sobremesas variadas"
        check "Inclui bebidas alcoólicas"
        check "Inclui decoração"
        select 'Em outro local', from: 'Local do evento'
        click_on 'Criar tipo de evento'

        #Assert
        expect(current_path).to eq buffet_path(buffet.id)
        expect(page).to have_content("Casamento")
        expect(page).to have_content("Temos o melhor buffet para casamentos.")

    end

end