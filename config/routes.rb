Rails.application.routes.draw do
  #Omniauth
  get '/auth/:provider/callback' => 'users#create'
end
