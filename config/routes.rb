Rails.application.routes.draw do
  root to: 'users#new'

  #Omniauth
  get '/auth/:provider/callback' => 'users#create'

  resources :users, except: [:show, :destroy, :index, :create]
end
