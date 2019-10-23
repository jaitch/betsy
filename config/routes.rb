Rails.application.routes.draw do
  resources :orders#, except: [:put]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root "homepages#index"
  
  resources :products
end
