Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resource :users, only: [:create]
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
  get "/user_is_authed", to: "users#user_is_authed"

  resources :restaurants
  resources :kits do
    member do
      get 'related_by_tag'
      get 'related_by_restaurant'
    end
  end
end
