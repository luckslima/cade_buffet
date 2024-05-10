# config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*'  # Em produção, substitua '*' por domínios específicos
      resource '*',
        headers: :any,
        methods: [:get, :post, :patch, :put, :delete, :options, :head]
    end
  end
  