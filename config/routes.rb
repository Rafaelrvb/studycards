Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/search', to: 'decks#index'

  get '/decks/new', to: 'decks#new', as: :new
  post '/decks/create', to: 'decks#create', as: :create
  get '/decks/:id', to: 'decks#show', as: :show

    # These routes are nested in decks id
    get '/decks/:id/cards/new', to: 'cards#new', as: :new_card
    post '/decks/:id/cards/create', to: 'cards#create', as: :create_card
    get '/decks/:id/cards/index', to: 'cards#index', as: :list_cards
    patch '/cards/:id', to: 'cards#update', as: :update_card
    delete '/cards/:id', to: 'cards#destroy', as: :destroy_card



end
