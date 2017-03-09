Rails.application.routes.draw do

  root to: 'movies#index'

  resources :users, only: [:new, :create]

  resources :movies, only: [:index, :create, :edit, :update]

  namespace :api do
    namespace :v1 do
      resources :movies, only: [:update]
    end
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

end
