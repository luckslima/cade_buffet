require 'rails_helper'

RSpec.describe OrderBudget, type: :model do

    describe '#valid?' do
        it 'falso quando data de validade é nula' do
            #Arrange
            user = User.create!(name: 'Patricia', cpf: '21642440795', email: 'paty@gmail.com', password: 'paty123', is_buffet_owner: true)
            method_1 = PaymentMethod.create!(name: "Boleto Bancário")
            method_2 = PaymentMethod.create!(name: "Pix")
            buffet = Buffet.create!(brand_name: "Patty Buffet", corporate_name: "Patty Buffet LTDA", registration_number: "1254783654", 
                                    phone: "71-85642014", email: "pattybuffet@email.com", address: "Av oceânica, 100", district: "Barra", 
                                    city: "Salvador", state: "Bahia", zip_code: "40527-700", 
                                    description: "Buffet para casamentos e festas de 15 anos", user: user)
            buffet.payment_methods << [method_1, method_2]
            event_type = EventType.create!(name: 'Halloween', description: 'Doces e deliciosas travessuras', min_guests: 50, max_guests: 500, 
                                        duration_minutes: 300, menu_description: 'Massas, saladas e Sobremesas', alcohol_included: true, 
                                        parking_available: true, location_type: 'on_site', buffet: buffet)
            event_price = EventPrice.create!(base_price: 7000, additional_guest_price: 200, extra_hour_price: 600, price_for_weekend: true, event_type: event_type)
            event_price = EventPrice.create!(base_price: 6000, additional_guest_price: 200, extra_hour_price: 600, price_for_weekend: false, event_type: event_type)
            client = User.create!(name: 'João', cpf: '75212608805', email: 'joao@email.com', password: 'joao123', is_buffet_owner: false)
            order = Order.create!(buffet: buffet, user:client, event_type: event_type, number_of_guests: 150, 
                                event_date: 1.month.from_now, details: 'Halloween fora de época', payment_method: method_2, status: :approved)
            order_budget = OrderBudget.new(user: client, buffet: buffet, order: order, valid_until: nil, payment_method: method_2)

            #Act
            result = order_budget.valid?

            #Assert
            expect(result).to eq false
 
        end
    end

end
