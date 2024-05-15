require 'rails_helper'

describe 'Usuário dono de buffet cadastra tipo de evento' do

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
        attach_file 'Imagem', Rails.root.join('spec', 'support', 'casamento.jpg')
        click_on 'Salvar'

        #Assert
        expect(current_path).to eq buffet_path(buffet.id)
        expect(page).to have_content("Casamento")
        expect(page).to have_content("Temos o melhor buffet para casamentos.")
        expect(EventType.last.image).to be_attached

    end

end