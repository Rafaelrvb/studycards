Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/search', to: 'decks#index'

  get '/deck/new', to: 'decks#new', as: :new
  get '/deck/create', to: 'decks#create', as: :create
  get '/deck/:id', to: 'decks#show', as: :show
end
