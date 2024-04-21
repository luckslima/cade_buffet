require 'rails_helper'

describe 'Usuário se cadastra' do

    it 'a partir do menu' do
        #Arrange

        #Act
        visit root_path

        #Assert 
        expect(page).to have_content('Cadastrar')

    end

    it 'com sucesso' do
        #Arrange

        #Act
        visit root_path
        click_on 'Cadastrar'
        fill_in 'Nome', with: 'Maria'
        fill_in 'E-mail', with: 'maria@email.com'
        fill_in 'Senha', with: 'maria123'
        fill_in 'Confirme sua senha', with: 'maria123'
        click_on 'Criar conta'

        #Assert
        expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
        expect(page).to have_content 'Maria'
        expect(page).to have_content 'Sair'

    end

    it 'e é redirecionado para a página de cadastro de buffet' do
        #Arrange

        #Act
        visit root_path
        click_on 'Cadastrar'
        fill_in 'Nome', with: 'Maria'
        fill_in 'E-mail', with: 'maria@email.com'
        fill_in 'Senha', with: 'maria123'
        fill_in 'Confirme sua senha', with: 'maria123'
        check "Possuo um Buffet."
        click_on 'Criar conta'

        #Assert
        expect(current_path).to eq new_buffet_path
        expect(page).to have_content 'Agora só falta cadastrar o seu buffet!'
        expect(page).to have_content 'Sair'
    end

end