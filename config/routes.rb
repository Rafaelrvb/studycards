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

    resources :deck_communities, only: [:show,:destroy]
    get '/deck_community/:id', to: 'deck_communities#create', as: :addcollection

  # Routes for Studies Controller:
    get '/deck_community/:deck_community_id/studies/new', to: 'studies#new', as: :new_study
    post '/deck_community/:deck_community_id/studies/create', to: 'studies#create', as: :create_study

  # Routes for Reviews
  get '/decks/:id/deck_reviews/new', to: 'deck_reviews#new', as: :new_deck_review
  post '/decks/:id/deck_reviews', to: 'deck_reviews#create', as: :deck_reviews
  get 'deck_reviews/destroy'

end
