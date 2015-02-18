Rails.application.routes.draw do
  devise_for :users
  get 'restaurants' => 'restaurants#index'
  get 'new_restaurant' => 'restaurants#new'
  root to: "restaurants#index"

  resources :restaurants do
    resources :reviews
  end
end
