require 'rails_helper'

describe 'Usuário se autentica' do

    it 'com sucesso' do
        #Arrange 
        User.create!(name: 'João', email: 'joao@email.com', password: 'password', is_buffet_owner: false)

        #Act
        visit root_path
        click_on 'Entrar'
        fill_in 'E-mail', with: 'joao@email.com'
        fill_in 'Senha', with: 'password'
        within('#login-form') do
            click_on 'Entrar'
        end

        #Assert
        expect(page).to have_button 'Sair'
        expect(page).not_to have_link 'Entrar'
        within('nav') do
            expect(page).to have_content 'João'
        end
        expect(page).to have_content 'Login efetuado com sucesso.'

    end

    it 'e faz logout' do
        #Arrange 
        User.create!(name: 'João', email: 'joao@email.com', password: 'password', is_buffet_owner: false)

        #Act
        visit root_path
        click_on 'Entrar'
        fill_in 'E-mail', with: 'joao@email.com'
        fill_in 'Senha', with: 'password'
        within('#login-form') do
            click_on 'Entrar'
        end
        click_on 'Sair'

        #Assert
        expect(page).to have_link 'Entrar' 
        expect(page).not_to have_button 'Sair'
        within('nav') do
            expect(page).not_to have_content 'João'
        end
        expect(page).to have_content 'Logout efetuado com sucesso.'
    end

end