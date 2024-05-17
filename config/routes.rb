Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index' 

  resources :buffets, only: [:new, :create, :show, :edit, :update] do
    get 'search', on: :collection
    get 'deactivate', on: :member
    get 'activate', on: :member
  end


  resources :event_types, only: [:show, :new, :create, :edit, :update] do
    resources :event_prices, only: [:new, :create, :edit, :update]
    resources :orders, only: [:new, :create]
    get 'deactivate', on: :member
    get 'activate', on: :member
  end

  resources :orders, only: [:index, :show] do
    resources :order_budgets, only: [:new, :create] 
    post 'confirmed', on: :member
    resources :messages, only: [:create]
  end

  namespace :api do 
    namespace :v1 do
      resources :buffets, only: [:show, :index] do
        resources :event_types, only: [:index] do
          get 'availability', on: :member
        end
      end
    end
  end

end
