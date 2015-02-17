Rails.application.routes.draw do
  get 'restaurants' => 'restaurants#index'
  get 'new_restaurant' => 'restaurants#new'

  resources :restaurants
end
