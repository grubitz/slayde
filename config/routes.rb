Rails.application.routes.draw do
  resources :users
  get '/games/new', to: 'games#new'
  post '/games/check', to: 'games#check'
end
