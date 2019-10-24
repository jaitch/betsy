Rails.application.routes.draw do
  resources :orders#, except: [:put]
  get '/cart/:id', to: 'application#add_to_cart' , as: 'cart'

  root "products#index"

  resources :products
end
