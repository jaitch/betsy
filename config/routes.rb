Rails.application.routes.draw do
  resources :orders#, except: [:put]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  root "homepages#index"

  resources :products do
    get '/cart', to: 'application#add_item' , as: 'cart'
  end

  resources :merchants

  # get "/login", to: "merchants#login_form", as: "login"
  # post "/login", to: "merchants#login"
  # post "/logout", to: "merchants#logout", as: "logout"

  get "/merchants/current", to: "merchants#current", as: "current_merchant"

  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "merchants#create", as: "auth_callback"
  delete "/logout", to: "merchants#destroy", as: "logout"
end
