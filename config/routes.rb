Rails.application.routes.draw do
  get 'ratings/create'
  resources :movies
  get '/statistics', to: 'movies#stats', as: 'stats'
  resources :genres, only: [:index, :show]
  resources :ratings, only: [:create]

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
