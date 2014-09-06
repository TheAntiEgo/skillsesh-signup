Rails.application.routes.draw do
  root :to => 'signups#index'
  
  ##
  # Omniauth
  ##
  constraints :provider => /facebook|google|linkedin/ do
    match 'auth/:provider/callback' => 'users#create', :via => [:get, :post]
  end
  
  ##
  # Logout
  ##
  match '/signout' => 'sessions#destroy', :via => :delete, :as => 'signout'
  
  ##
  # Current user profile
  ##
  resource :profile, :only => [:show, :update]
end
