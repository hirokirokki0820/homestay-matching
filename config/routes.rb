Rails.application.routes.draw do
  root "home#index"
  get "about", to: "home#about"
  get "signup", to: "users#new"
  resources :users, except: [:new]

end
