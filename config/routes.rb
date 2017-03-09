Rails.application.routes.draw do

  root to: 'movies#index'

  resources :users, only: [:new, :create]

  resources :movies, only: [:index, :create, :edit, :update]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

end
