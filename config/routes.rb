Rails.application.routes.draw do
  root :to => 'signups#index'
  
  ##
  # Omniauth
  ##
  constraints :provider => /facebook|google|linkedin/ do
    match 'auth/:provider/callback' => 'signups#create', :via => [:get, :post], :as => 'register'
  end
  
  ##
  # Pre-Beta Signups
  ##
  get '/onboard' => 'signups#onboard', :as => 'onboard'
  get '/new_session' => 'signups#first_session', :as => 'first_session'
  match '/update' => 'signups#update', :via => [:patch, :put, :post]
    
  ##
  # Static pages
  ##
  scope :path => '/static_pages' do
    get 'faq' => 'static_pages#faq'
    get 'about' => 'static_pages#about'
    get 'resources' => 'static_pages#resources'
  end
  
  ##
  # Email signups
  ##
  post '/email_subscribe' => 'emails#create', :as => 'subscribe'
  
  ##
  # Login/Logout
  ##
  get '/signout' => 'sessions#destroy', :as => 'signout'
  
  ##
  # Current User:
  # + Profile
  # + Courses
  # + Messages
  ##
  resource :profile, :only => [:show, :update]
  
  ##
  # Users
  ##
  resources :users, :only => [:index, :create, :show]
  
  ##
  # Courses
  ##
  resources :courses, :except => [:new, :edit] do
    resource :purchase, :only => [:new, :create, :destroy]
  end
  
  resource :conversations, :only => [:create, :update]
  
  
  ##
  # Skills
  ##
  resources :skills, :only => [:index]
end
