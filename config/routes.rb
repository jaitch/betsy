Rails.application.routes.draw do
  resources :orders#, except: [:put]
  get '/orders/:id/checkout', to: 'orders#checkout', as: 'checkout'

  root "homepages#index"

  resources :products


  resources :merchants
  get "/login", to: "merchants#login_form", as: "login"
  post "/login", to: "merchants#login"
  post "/logout", to: "merchants#logout", as: "logout"
  get "/merchants/current", to: "merchants#current", as: "current_merchant"
end
