Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resource :users, only: [:create]
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
  get "/user_is_authed", to: "users#user_is_authed"

  resources :restaurants
  resources :kits
  get 'restaurant_kits/:id', to: "kits#restaurant_kits"
end
