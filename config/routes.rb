Rails.application.routes.draw do
  root :to => 'signups#index'
  
  ##
  # Omniauth
  ##
  constraints :provider => /facebook|google|linkedin/ do
    match 'auth/:provider/callback' => 'users#create', :via => [:get, :post]
  end
  
  ##
  # Pre-Beta Signups
  ##
  get '/onboard' => 'signups#onboard', :as => 'onboard'
  get '/new_session' => 'signups#first_session', :as => 'first_session'
  post '/update' => 'signups#update'
  
  ##
  # Login/Logout
  ##
  delete '/signout' => 'sessions#destroy', :as => 'signout'
  
  ##
  # Current User:
  # + Profile
  # + Courses
  # + Messages
  ##
  resource :profile, :only => [:show, :update] do
    resources :courses, :controller => 'courses'
    resources :messages, :controller => 'messages'
  end
  
  ##
  # Users
  ##
  resources :users, :only => [:index, :create, :show]
  
  ##
  # Courses
  ##
  resources :courses, :only => [:index, :show] do
    resource :purchase, :only => [:new, :create, :destroy]
  end
  
  ##
  # Skills
  ##
  resources :skills, :only => [:index]
end
