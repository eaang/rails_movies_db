Rails.application.routes.draw do
  resources :movies
  get '/statistics', to: 'movies#stats', as: 'stats'
  match '/change', to: 'ratings#change', via: [:get, :post]
  resources :genres, only: [:index, :show]
  devise_for :users
  resources :users, only: [:show, :edit]
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
