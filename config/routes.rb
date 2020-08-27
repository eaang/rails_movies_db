Rails.application.routes.draw do
  resources :movies
  get '/statistics', to: 'movies#stats', as: 'stats'
  resources :genres, only: [:index, :show]
  resources :ratings, only: [:create, :update]

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
