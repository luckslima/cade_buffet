require 'rails_helper'

describe 'Usuário se cadastra' do
    it 'com sucesso' do
        #Arrange

        #Act
        visit root_path
        click_on 'Cadastrar'
        #fill_in 'Nome', with: 'Maria'
        fill_in 'E-mail', with: 'maria@email.com'
        fill_in 'Senha', with: 'maria123'
        fill_in 'Confirme sua senha', with: 'maria123'
        #selecionar "Dono de buffet"
        click_on 'Criar conta'

        #Assert
        expect(current_path).to eq new_buffet_path

    end

end