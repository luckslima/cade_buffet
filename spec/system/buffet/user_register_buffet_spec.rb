require "rails_helper"

describe 'Usuário registra um buffet' do 
    it 'a partir da tela inical' do
        #Arrange
        user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
        PaymentMethod.create!(name: "Boleto Bancário")
        PaymentMethod.create!(name: "Cartão de Crédito")

        #Act
        login_as(user)
        visit root_path

        #Assert
        expect(page).to have_field('Nome Fantasia')
        expect(page).to have_field('Razão Social')
        expect(page).to have_field('CNPJ')
        expect(page).to have_field('Telefone')
        expect(page).to have_field('E-mail')
        expect(page).to have_field('Endereço')
        expect(page).to have_field('Bairro')
        expect(page).to have_field('Estado')
        expect(page).to have_field('Cidade')
        expect(page).to have_field('CEP')
        expect(page).to have_field('Descrição')
        expect(page).to have_content('Meios de Pagamento')
        expect(page).to have_content('Boleto Bancário')
        expect(page).to have_content('Cartão de Crédito')
    end

    it 'com sucesso' do
        #Arrange
        user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
        PaymentMethod.create!(name: "Boleto Bancário")
        PaymentMethod.create!(name: "Cartão de Crédito")
        
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
        check "Boleto Bancário"
        check "Cartão de Crédito"
        click_on 'Salvar Buffet'

        #Assert 
        expect(page).to have_content("Buffet cadastrado com sucesso!")
        expect(page).to have_content("Patty Buffet")

    end

    it 'com dados incompletos' do
        #Arrange
        user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
        PaymentMethod.create!(name: "Boleto Bancário")
        PaymentMethod.create!(name: "Cartão de Crédito")

        #Act
        login_as(user)
        visit root_path
        fill_in "Nome Fantasia", with: ""
        fill_in "Razão Social", with: "Patty Buffet LTDA"
        fill_in "CNPJ", with: ""
        fill_in "Telefone", with: "71-85642014"
        fill_in "E-mail", with: ""
        fill_in "Endereço", with: "Av oceânica, 100"
        fill_in "Bairro", with: "Barra"
        fill_in "Estado", with: "Bahia"
        fill_in "Cidade", with: "Salvador"
        fill_in "CEP", with: "40527-700"
        fill_in "Descrição", with: "Buffet para casamentos e festas de 15 anos"
        check "Boleto Bancário"
        check "Cartão de Crédito"
        click_on 'Salvar Buffet'

        #Assert
        expect(page).to have_content 'Não foi possível cadastrar o buffet.'
        expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
        expect(page).to have_content 'CNPJ não pode ficar em branco'
        expect(page).to have_content 'E-mail não pode ficar em branco'

    end
end