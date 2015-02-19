Rails.application.routes.draw do
  get 'restaurants' => 'restaurants#index'
  get 'new_restaurant' => 'restaurants#new'
  root to: "restaurants#index"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :restaurants do
    resources :reviews
  end

  # devise_scope :user do
  #   get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end
end
