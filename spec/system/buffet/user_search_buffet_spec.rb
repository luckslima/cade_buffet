require 'rails_helper'

describe 'Usuário visitante busca por um buffet' do 

    it 'a partir do menu' do
        #Arrange 

        #Act
        visit root_path


        #Assert
        within('header nav') do
            expect(page).to have_field('Buscar Buffet')
            expect(page).to have_button('Buscar')
        end

    end

    it 'e encontra o buffet pelo nome fantasia' do 
        #Arrange
        user = User.create!(name: 'Patricia',  cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
        buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", description: "Buffet para casamentos e festas de 15 anos", 
                                payment_methods: "Boleto e Cartão", user: user)
        event_type = EventType.create!(name: 'Halloween', description: 'Doces e deliciosas travessuras', min_guests: 50, max_guests: 500, 
                                duration_minutes: 300, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                parking_available: true, location_type: 'on_site', buffet: buffet)
        
        #Act
        visit root_path
        fill_in 'Buscar Buffet', with: 'Patty'
        click_on 'Buscar'

        #Assert
        expect(current_path).to eq search_buffets_path
        expect(page).to have_content 'Patty Buffet'
        expect(page).to have_content 'Salvador | Bahia'

    end

    it 'e encontra o buffet pela cidade' do 
        #Arrange
        user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
        buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", description: "Buffet para casamentos e festas de 15 anos", 
                                payment_methods: "Boleto e Cartão", user: user)
        event_type = EventType.create!(name: 'Halloween', description: 'Doces e deliciosas travessuras', min_guests: 50, max_guests: 500, 
                                duration_minutes: 300, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                parking_available: true, location_type: 'on_site', buffet: buffet)
        
        #Act
        visit root_path
        fill_in 'Buscar Buffet', with: 'Salvador'
        click_on 'Buscar'

        #Assert
        expect(current_path).to eq search_buffets_path
        expect(page).to have_content 'Patty Buffet'
        expect(page).to have_content 'Salvador | Bahia'

    end

    it 'e encontra o buffet pelo tipo de evento' do 
        #Arrange
        user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
        buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", description: "Buffet para casamentos e festas de 15 anos", 
                                payment_methods: "Boleto e Cartão", user: user)
        event_type_1 = EventType.create!(name: 'Halloween', description: 'Doces e deliciosas travessuras', min_guests: 50, max_guests: 500, 
                                duration_minutes: 300, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                parking_available: true, location_type: 'on_site', buffet: buffet)
        event_type_2 = EventType.create!(name: 'Formatura', description: 'Para grandes formaturas', min_guests: 100, max_guests: 1000, 
                                duration_minutes: 360, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                parking_available: true, location_type: 'on_site', buffet: buffet)
        
        #Act
        visit root_path
        fill_in 'Buscar Buffet', with: 'Halloween'
        click_on 'Buscar'

        #Assert
        expect(current_path).to eq search_buffets_path
        expect(page).to have_content 'Patty Buffet'
        expect(page).to have_content 'Salvador | Bahia'

    end

    it 'e encontra múltiplos buffets' do
        #Arrange
        user_1 = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
        user_2 = User.create!(name: 'Victor', cpf: '98338378402', email: 'vitinho@gmail.com', password: 'vitor123', is_buffet_owner: true)
        user_3 = User.create!(name: 'João', cpf: '64421826146', email: 'joão@gmail.com', password: 'joao123', is_buffet_owner: true)
        buffet_1 = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", description: "Buffet para casamentos e festas de 15 anos", 
                                payment_methods: "Boleto e Cartão", user: user_1)
        buffet_2 = Buffet.create!(brand_name: "Vitinho do Buffet", corporate_name: "Vitinho do Buffet LTDA", registration_number: "251715366833", 
                                    phone: "55-89742994", email: "buffetviti@email.com", address: "Av contorno, 100", district: "Comércio", 
                                    city: "São Paulo", state: "SP", zip_code: "403647-460", description: "Buffet para todas as horas!", 
                                    payment_methods: "Boleto e Cartão", user: user_2)
        buffet_3 = Buffet.create!(brand_name: "Banquete do João", corporate_name: "Banquete do João LTDA", registration_number: "251715366000", 
                                        phone: "54-89733394", email: "buffetdojoao@email.com", address: "Av Lina Bo, 300", district: "Paulista", 
                                        city: "São Paulo", state: "SP", zip_code: "503687-220", description: "Buffet radical!", 
                                        payment_methods: "Boleto e Cartão", user: user_3)
        
        #Act
        visit root_path
        fill_in 'Buscar Buffet', with: 'Buffet'
        click_on 'Buscar'

        #Assert
        expect(page).to have_content '2 buffets encontrados'
        expect(page).to have_content "Patty Buffet"
        expect(page).to have_content "Vitinho do Buffet"
        expect(page).not_to have_content "Banquete do João"

    end

    it 'e encontra buffets ordenados em ordem alfabética' do
        #Arrange
        user_1 = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
        user_2 = User.create!(name: 'Victor', cpf: '98338378402', email: 'vitinho@gmail.com', password: 'vitor123', is_buffet_owner: true)
        user_3 = User.create!(name: 'João', cpf: '64421826146', email: 'joão@gmail.com', password: 'joao123', is_buffet_owner: true)
        buffet_3 = Buffet.create!(brand_name: "Buffet do João", corporate_name: "Banquete do João LTDA", registration_number: "251715366000", 
                                  phone: "54-89733394", email: "buffetdojoao@email.com", address: "Av Lina Bo, 300", district: "Paulista", 
                                  city: "São Paulo", state: "SP", zip_code: "503687-220", description: "Buffet radical!", 
                                  payment_methods: "Boleto e Cartão", user: user_3)
        buffet_1 = Buffet.create!(brand_name: "A Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                city: "Salvador", state: "Bahia", zip_code: "40527-700", description: "Buffet para casamentos e festas de 15 anos", 
                                payment_methods: "Boleto e Cartão", user: user_1)
        buffet_2 = Buffet.create!(brand_name: "Vitinho do Buffet", corporate_name: "Vitinho do Buffet LTDA", registration_number: "251715366833", 
                                    phone: "55-89742994", email: "buffetviti@email.com", address: "Av contorno, 100", district: "Comércio", 
                                    city: "São Paulo", state: "SP", zip_code: "403647-460", description: "Buffet para todas as horas!", 
                                    payment_methods: "Boleto e Cartão", user: user_2)

        #Act
        visit root_path
        fill_in 'Buscar Buffet', with: 'Buffet'
        click_on 'Buscar'
        
        #Assert 

        

    end

end