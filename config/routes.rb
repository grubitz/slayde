Rails.application.routes.draw do
  get '/games/new', to: 'games#new'
  post '/games/check', to: 'games#check'
end
