Rails.application.routes.draw do
  resources :orders#, except: [:put]
end
