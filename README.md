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

