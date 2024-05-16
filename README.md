# Cadê Buffet? :birthday:

> Status do Projeto: Em desenvolvimento :warning:

## Descrição do Projeto: :memo:

 <p align="justify"> Esse projeto foi desenvolvido durante o processo de treinamento da 12ª edição do Treina Dev, ministrado pela Campus Code. A app tem como objetivo funcionar como um site onde usuários encontram um Buffet de acordo com suas necessidades e donos de buffet cadastram o Buffet e seus serviços para que usuários possam contrata-los. </p>

## Pré-requisitos:

* Ruby 3.1.0

* Rails 7.1.3

* Devise 

* Rspec-Rails

* Capybara

* Ambiente linux (Opcional mas nem tanto para projetos em Ruby)

## Principais Funcionalidades: 

- [X] Cadastro de conta como Dono de Buffet
- [X] Cadastro de conta como Cliente 
- [X] Cadastro de Buffet
- [X] Adicionar tipos de evento para um Buffet
- [X] Vincular preços a um tipo de evento 
- [X] Listagem de Buffets cadastrados na página principal 
- [X] Busca por um Buffet 
- [X] Ver tipos de eventos que um Buffet oferece e seus preços 
- [X] Um Cliente pode contratar um Buffet criando um pedido para um evento
- [X] Clientes e Donos de Buffet podem ver e acessar pedidos feitos
- [X] Donos de Buffet podem aprovar pedidos feitos por clientes.
- [X] Clientes podem confirmar pedidos aprovados por Donos de Buffet, desde que estejam dentro do prazo.
- [X] Clientes e Donos de Buffet podem trocar mensagens dentro da página de detalhes de um pedido.

## Como Rodar a Aplicação? :arrow_forward:

- No terminal, clone o projeto:

  > git clone https://github.com/luckslima/cade_buffet.git

- Entre na pasta do projeto:

  > cd cade_buffet

- Instale as dependencias:

  > bundle install 

- Rode as migrações:

  > rails db:migrate 

- Popule o banco de dados

  > rails db:seed

- Execute a aplicação: 

  > rails server

Pronto! Agora é possível acessar a aplicação através da rota http://localhost:3000/ :wink:

## Usuários

Para se cadastrar um usuário deve informar o nome, um cpf válido, um email e uma senha. E ao se cadastrar, o usuário pode informar se ele é um dono de buffet selecionado uma checkbox. Se ele não for, isso significa que ele é um usuário do tipo cliente. Os dois possuem funcionalidades próprias, que serão explicadas logo abaixo.

### Donos de Buffet

- Buffets:

> Se um usuário se cadastra como dono de buffet, o próximo passo é cadastrar o buffet, não sendo possível ir para outra tela da aplicação (exceto logout). Para registrar o buffet, o dono dever informar o nome fantasia, razão social, CNPJ, telefone para contato, e-mail para contato e endereço completo com endereço, bairro, estado, cidade e CEP. Além destes dados, o dono do buffet deve poder adicionar uma descrição de seu buffet, os meios de pagamentos aceitos e uma imagem de capa. O usuário dono de buffet é o único capaz de editar os dados de seu próprio buffet. E não é possível excluir um buffet.

- Tipos de evento:

> Um buffet pode oferecer diferentes tipos de eventos: festas de 15 anos, festas de casamento, serviço de buffet para conferências e congressos, festas corporativas etc. Cada dono de buffet pode cadastrar os tipos de evento que realiza. Para cada tipo de evento ele deve informar: nome, descrição, quantidade mínima e máxima de pessoas que podem ser atendidas e a duração padrão do evento em minutos. Cada tipo de evento deve possuir também um texto que indica o cardápio para o evento. E deve ser informado se o evento possui opção de: bebidas alcoólicas, decoração e serviço de estacionamento ou valet. Para cada tipo de evento, o dono do buffet precisa indicar se o evento deve ser realizado exclusivamente no endereço do buffet ou se pode ser feito em um endereço indicado pelo cliente. O dono do Buffet pode também inserir uma imagem de capa para cada tipo de evento. 

- Preços por tipo de evento:

> Um dono de um buffet pode, para cada tipo de evento, definir os preços-base daquele tipo de evento. Cada preço-base deve conter o valor mínimo (que está ligado com a quantidade mínima de pessoas) e deve haver um valor adicional por pessoa. Lembre-se que os valores aqui não são necessariamente lineares. Por exemplo: uma festa infantil com mínimo de 20 pessoas pode ter o preço-base de R$ 2.000,00, mas o valor adicional por pessoa pode ser de R$ 70,00. Pode ser cadastrado também o valor por hora extra do evento, caso o evento extrapole a duração-padrão. Os preços por tipo de evento são diferenciados caso a festa seja realizada durante os dias da semana ou durante o fim de semana, então é possível cadastrar, para cada tipo de evento, duas configurações diferentes de preço.

- Pedidos

> Para cada tipo de evento é possível receber pedidos de clientes, o pedido contem o nome do buffet, o tipo de evento escolhido, a data desejada, a quantidade estimada de convidados e um campo para informar mais detalhes sobre o evento. Cada pedido possui um código alfanumérico de 8 caracteres gerado automaticamente. E caso o tipo de evento escolhido tenha a opção de realizar em um endereço diferente do endereço do buffet, o cliente informa também o endereço desejado para o evento. Com base nessas informações é possível o dono do Buffet avaliar e aprovar o pedido, que já é criado com o status de pedido pendente. 

- Orçamentos

> Para aprovar um pedido, o dono do buffet deve gerar um orçamento para um pedido, (que quando é criado a aplicação já calcula um preço base a partir dos preços do evento escolhido) informando se existem taxas extras, descontos e também informando detalhes sobre o orçamento e o método de pagamento. Ao gerar o orçamento o pedido é aprovado e a aplicação registra o preço final. 

### Clientes 

- Procurar buffets

> Tanto visitantes da página quanto clientes podem procurar um buffet pelo nome, cidade ou tipo de evento, ou simplesmente podem procurar por um buffet pela tela inicial, que já exibe uma lista de todos os buffets cadastrados.

- Ver detalhes de um buffet

> Ao clicar no nome de um buffet o usuário é redirecionado para uma tela de detalhes do buffet, onde ele pode checar todas as informações do buffet (exceto razão social), e todos os tipos de evento realizados e seus respectivos preços.

- Pedidos 

> Quando um cliente clica em um tipo de evento realizado é possível ele fazer um pedido daquele evento para o buffet. Para isso ele deve informar a data desejada, a quantidade estimada de convidados, detalhes sobre o evento e ,se o tipo de evento permitir a realização em outro lugar, o cliente deve informar também o endereço de onde o evento irá acontecer. Com isso um pedido é criado, e o cliente pode aguardar a aprovação do buffet e, se ela acontecer, pode confirmar o pedido. 


## API Cadê Buffet?

### Endpoints: 

- 'GET /api/v1/buffets' 

> Nesse endpoint é retornado uma listagem de todos os buffets cadastrados, com todos os seus atributos, no padrão Json. Nesse endpoint é possível passar um parametro de busca na url, chamado "search" para buscar um buffet pelo seu nome (brand_name). 

- 'GET /api/v1/buffets/:id'

> A partir desse endpoint é retornado um objeto Json com informações de um determinado buffet, com todos os seus atributos, exceto corporate_name (razão social) e registration_number (CNPJ)

- 'GET /api/v1/buffets/:buffet_id/event_types'

> A partir de um buffet é possível obter uma listagem de todos os tipos de eventos que ele realiza através desse endpoint.

- 'GET /api/v1/buffets/:buffet_id/event_types/:id/availability'

> Selecionando um tipo de evento de um buffet e informando uma data e quantidade de convidados, esse endpoint retorna um objeto contendo a disponibilidade do buffet em fazer o evento, e se positivo retorna também o valor estimado da realização do evento. Observe os exemplos de retorno abaixo:
    
    * Em caso de sucesso:

      { available: true, estimated_price: 10000 }

    * Em caso de falha:

      { error: "motivo do erro ou da indisponibilidade" } 

