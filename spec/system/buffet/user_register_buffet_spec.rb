require "rails_helper"

describe 'Usuário registra um buffet' do 
    it 'com sucesso' do
        #Arrange
        user = User.create!(name: 'Patricia', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
        
        #Act
        login_as(user)
        visit root_path
        fill_in "Nome Fantasia", with: "Patty Buffet"
        fill_in "Razão Social", with: "Patty Buffet LTDA"
        fill_in "CNPJ", with: "1254783654"
        fill_in "Telefone", with: "71-85642014"
        fill_in "E-mail", with: "pattybuffet@email.com"
        fill_in "Endereço", with: "Av oceânica, 100"
        fill_in "Bairro", with: "Barra"
        fill_in "Estado", with: "Bahia"
        fill_in "Cidade", with: "Salvador"
        fill_in "CEP", with: "40527-700"
        fill_in "Descrição", with: "Buffet para casamentos e festas de 15 anos"
        fill_in "Meios de Pagamento", with: "Boleto e Cartão"
        click_on 'Cadastrar Buffet'

        #Assert 
        expect(page).to have_content("Buffet cadastrado com sucesso!")
        expect(page).to have_content("Patty Buffet")

    end
end