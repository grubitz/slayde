Rails.application.routes.draw do
  root to: 'users#index'
  get 'email_confirmation/:token', to: 'email_confirmations#confirm', as: 'confirmation'

  resources :users
  get '/games/new', to: 'games#new'
  post '/games/check', to: 'games#check'

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :registrations, only: [:new, :create]

end
