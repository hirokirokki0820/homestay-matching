Rails.application.routes.draw do
  root "home#index"
  get "about", to: "home#about"
  get "signup", to: "users#new"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  resources :users, except: [:new], param: :account_name
  resources :account, only: [:edit, :update, :destroy], param: :account_name
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :posts
end
