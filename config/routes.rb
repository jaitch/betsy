Rails.application.routes.draw do
  resources :orders#, except: [:put] do
  get "/confirmation/:id", to: "orders#confirmation", as: "confirmation"

  resources :orderproducts, except: [:create]

  root "homepages#index"

  resources :products do
    resources :orderproducts, only: [:create, :destroy]
  end

  resources :merchants

  resources :categories

  # get "/login", to: "merchants#login_form", as: "login"
  # post "/login", to: "merchants#login"
  # post "/logout", to: "merchants#logout", as: "logout"

  get "/merchants/current", to: "merchants#current", as: "current_merchant"

  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "merchants#create", as: "auth_callback"
  delete "/logout", to: "merchants#destroy", as: "logout"
end
