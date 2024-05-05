# Users (Buffet Owners)
lucas = User.create!(name: 'Lucas Lima', cpf: '77221864241', email: 'lucasl@gmail.com', password: 'lucas123', is_buffet_owner: true)
sofia = User.create!(name: 'Sofia Santos', cpf: '06172714538', email: 'sofiasts@email.com', password: 'sofia123', is_buffet_owner: true)
gabriel = User.create!(name: 'Gabriel de Alencar', cpf: '31624818307', email: 'gabideal@hotmail.com', password: 'gabi123', is_buffet_owner: true)
ana = User.create!(name: 'Ana Carla', cpf: '42761378709', email: 'anacla@hotmail.com', password: 'ana123', is_buffet_owner: true)

# Users (clients)

cliente1 = User.create!(name: 'Mariana Costa', cpf: '21784203700', email: 'mari.costa@gmail.com', password: 'maripass', is_buffet_owner: false)
cliente2 = User.create!(name: 'Ricardo Silva', cpf: '93071672810', email: 'ricardo.silva@gmail.com', password: 'ricardopass', is_buffet_owner: false)
cliente3 = User.create!(name: 'Julia Martins', cpf: '18534225680', email: 'julia.m@gmail.com', password: 'juliamartins', is_buffet_owner: false)

# Métodos de pagamento disponíveis

payment_methods = PaymentMethod.create([
  { name: "Cartão de Crédito" },
  { name: "Boleto Bancário" },
  { name: "PayPal" },
  { name: "Pix" },
  { name: "Dinheiro" }
])

# Buffets

buffet_1 = Buffet.create!(
  brand_name: "Luke's Buffet",
  corporate_name: "Luke's Buffet LTDA",
  registration_number: "36817610000120",
  phone: "71-88442014",
  email: "lukesbuffet@email.com",
  address: "Av oceânica, 100",
  district: "Barra",
  city: "Salvador",
  state: "Bahia",
  zip_code: "40527-700",
  description: "Buffet radical para todas as horas!",
  user: lucas
)
buffet_1.payment_methods << [payment_methods[0], payment_methods[1], payment_methods[3]] 

buffet_2 = Buffet.create!(
  brand_name: "Sofia's Delights",
  corporate_name: "Sofia Santos Eventos Ltda",
  registration_number: "47025410000196",
  phone: "31-982244581",
  email: "contact@sofiasdelights.com",
  address: "Rua das Palmeiras, 287",
  district: "Centro",
  city: "Belo Horizonte",
  state: "Minas Gerais",
  zip_code: "30130-160",
  description: "Eventos memoráveis com um toque pessoal.",
  user: sofia
)
buffet_2.payment_methods << [payment_methods[0], payment_methods[3]]

buffet_3 = Buffet.create!(
  brand_name: "Buffet do Biel",
  corporate_name: "Buffet do Gabriel Alencar Eireli",
  registration_number: "52924471000158",
  phone: "85-977355641",
  email: "gabisbuffet@contact.com",
  address: "Av. Beira Mar, 1020",
  district: "Praia de Iracema",
  city: "Fortaleza",
  state: "Ceará",
  zip_code: "60165-121",
  description: "Luxo e elegância em cada detalhe.",
  user: gabriel
)
buffet_3.payment_methods << [payment_methods[0], payment_methods[1], payment_methods[4]]

buffet_4 = Buffet.create!(
  brand_name: "Buffet Ana Carla",
  corporate_name: "AC Eventos S/A",
  registration_number: "14796352000177",
  phone: "21-33445566",
  email: "events@anacarla.com",
  address: "Largo do Machado, 29",
  district: "Catete",
  city: "Rio de Janeiro",
  state: "Rio de Janeiro",
  zip_code: "22221-020",
  description: "Transformamos seu sonho em realidade.",
  user: ana
)
buffet_4.payment_methods << [payment_methods[0], payment_methods[3]]


#Tipos de Evento

# Eventos para o Buffet do Lucas (buffet_1)
event_type1 = EventType.create!(
  name: 'Halloween',
  description: 'Doces e deliciosas travessuras',
  min_guests: 50,
  max_guests: 500,
  duration_minutes: 300,
  menu_description: 'Massas, saladas e Sobremesas',
  alcohol_included: true,
  parking_available: true,
  location_type: 'on_site',
  buffet: buffet_1
)

event_type2 = EventType.create!(
  name: 'Casamento na Praia',
  description: 'Um belo casamento com vista para o mar',
  min_guests: 100,
  max_guests: 300,
  duration_minutes: 480,
  menu_description: 'Frutos do mar, coquetéis e sorvetes',
  alcohol_included: true,
  parking_available: false,
  location_type: 'off_site',
  buffet: buffet_1
)

# Eventos para o Buffet da Sofia (buffet_2)
event_type3 = EventType.create!(
  name: 'Aniversário Infantil',
  description: 'Festa colorida com muitas brincadeiras',
  min_guests: 20,
  max_guests: 200,
  duration_minutes: 180,
  menu_description: 'Mini hamburgers, batata frita e cupcakes',
  alcohol_included: false,
  parking_available: true,
  location_type: 'on_site',
  buffet: buffet_2
)

event_type4 = EventType.create!(
  name: 'Gala Corporativa',
  description: 'Elegante evento de networking',
  min_guests: 150,
  max_guests: 700,
  duration_minutes: 360,
  menu_description: 'Cozinha internacional, vinhos e canapés',
  alcohol_included: true,
  parking_available: true,
  location_type: 'on_site',
  buffet: buffet_2
)

# Eventos para o Buffet do Gabriel (buffet_3)
event_type5 = EventType.create!(
  name: 'Carnaval Temático',
  description: 'Festa de Carnaval com temas variados',
  min_guests: 50,
  max_guests: 1000,
  duration_minutes: 420,
  menu_description: 'Petiscos brasileiros, caipirinhas e doces típicos',
  alcohol_included: true,
  parking_available: false,
  location_type: 'on_site',
  buffet: buffet_3
)

event_type6 = EventType.create!(
  name: 'Reunião de Negócios',
  description: 'Ambiente profissional para conferências e reuniões',
  min_guests: 10,
  max_guests: 100,
  duration_minutes: 240,
  menu_description: 'Café, chá e snacks saudáveis',
  alcohol_included: false,
  parking_available: true,
  location_type: 'on_site',
  buffet: buffet_3
)

# Eventos para o Buffet da Ana (buffet_4)
event_type7 = EventType.create!(
  name: 'Retiro de Yoga',
  description: 'Relaxamento e meditação em um ambiente tranquilo',
  min_guests: 15,
  max_guests: 100,
  duration_minutes: 720,
  menu_description: 'Comida vegetariana, sucos naturais e chás',
  alcohol_included: false,
  parking_available: true,
  location_type: 'on_site',
  buffet: buffet_4
)

event_type8 = EventType.create!(
  name: 'Formatura',
  description: 'Celebração da conclusão de curso',
  min_guests: 100,
  max_guests: 500,
  duration_minutes: 360,
  menu_description: 'Jantar formal, champagne e bolo de formatura',
  alcohol_included: true,
  parking_available: true,
  location_type: 'on_site',
  buffet: buffet_4
)


#Preços de tipo de evento 

# Preços para eventos do tipo "Halloween" (event_type1)
event_price1 = EventPrice.create!(
  base_price: 7000,
  additional_guest_price: 200,
  extra_hour_price: 600,
  price_for_weekend: false,
  event_type: event_type1
)

event_price2 = EventPrice.create!(
  base_price: 8000,
  additional_guest_price: 250,
  extra_hour_price: 800,
  price_for_weekend: true,
  event_type: event_type1
)

# Preços para eventos do tipo "Casamento na Praia" (event_type2)
event_price3 = EventPrice.create!(
  base_price: 15000,
  additional_guest_price: 300,
  extra_hour_price: 1000,
  price_for_weekend: false,
  event_type: event_type2
)

event_price4 = EventPrice.create!(
  base_price: 18000,
  additional_guest_price: 350,
  extra_hour_price: 1200,
  price_for_weekend: true,
  event_type: event_type2
)

# Preços para eventos do tipo "Aniversário Infantil" (event_type3)
event_price5 = EventPrice.create!(
  base_price: 5000,
  additional_guest_price: 100,
  extra_hour_price: 400,
  price_for_weekend: false,
  event_type: event_type3
)

event_price6 = EventPrice.create!(
  base_price: 6000,
  additional_guest_price: 150,
  extra_hour_price: 500,
  price_for_weekend: true,
  event_type: event_type3
)

# Preços para eventos do tipo "Gala Corporativa" (event_type4)
event_price7 = EventPrice.create!(
  base_price: 20000,
  additional_guest_price: 500,
  extra_hour_price: 1500,
  price_for_weekend: false,
  event_type: event_type4
)

event_price8 = EventPrice.create!(
  base_price: 25000,
  additional_guest_price: 550,
  extra_hour_price: 2000,
  price_for_weekend: true,
  event_type: event_type4
)

# Preços para eventos do tipo "Carnaval Temático" (event_type5)
event_price9 = EventPrice.create!(
  base_price: 12000,
  additional_guest_price: 400,
  extra_hour_price: 900,
  price_for_weekend: false,
  event_type: event_type5
)

event_price10 = EventPrice.create!(
  base_price: 14000,
  additional_guest_price: 450,
  extra_hour_price: 1100,
  price_for_weekend: true,
  event_type: event_type5
)

# Preços para eventos do tipo "Reunião de Negócios" (event_type6)
event_price11 = EventPrice.create!(
  base_price: 8000,
  additional_guest_price: 200,
  extra_hour_price: 700,
  price_for_weekend: false,
  event_type: event_type6
)

event_price12 = EventPrice.create!(
  base_price: 9000,
  additional_guest_price: 250,
  extra_hour_price: 800,
  price_for_weekend: true,
  event_type: event_type6
)

# Preços para eventos do tipo "Retiro de Yoga" (event_type7)
event_price13 = EventPrice.create!(
  base_price: 9000,
  additional_guest_price: 150,
  extra_hour_price: 500,
  price_for_weekend: false,
  event_type: event_type7
)

event_price14 = EventPrice.create!(
  base_price: 10000,
  additional_guest_price: 200,
  extra_hour_price: 600,
  price_for_weekend: true,
  event_type: event_type7
)

# Preços para eventos do tipo "Formatura" (event_type8)
event_price15 = EventPrice.create!(
  base_price: 13000,
  additional_guest_price: 300,
  extra_hour_price: 900,
  price_for_weekend: false,
  event_type: event_type8
)

event_price16 = EventPrice.create!(
  base_price: 15000,
  additional_guest_price: 350,
  extra_hour_price: 1100,
  price_for_weekend: true,
  event_type: event_type8
)

# Pedidos 

pedido1 = Order.create!(
  buffet: buffet_1,
  user: cliente1,
  event_type: event_type1,
  number_of_guests: 100,
  event_date: Date.today + 90.days,
  details: 'Festa de Halloween com temática clássica',
  payment_method: PaymentMethod.find_by(name: "Pix")
)

pedido2 = Order.create!(
  buffet: buffet_2,
  user: cliente2,
  event_type: event_type3,
  number_of_guests: 80,
  event_date: Date.today + 120.days,
  details: 'Aniversário infantil com tema de super-heróis',
  payment_method: PaymentMethod.find_by(name: "Cartão de Crédito")
)

pedido3 = Order.create!(
  buffet: buffet_4,
  user: cliente3,
  event_type: event_type7,
  number_of_guests: 40,
  event_date: Date.today + 180.days,
  details: 'Retiro de Yoga com foco em meditação e relaxamento',
  payment_method: PaymentMethod.find_by(name: "Pix")
)