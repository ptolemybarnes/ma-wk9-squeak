Rails.application.routes.draw do
  get 'restaurants' => 'restaurants#index'
  get 'new_restaurant' => 'restaurants#new'

  resources :restaurants do
    resources :reviews
  end
end
