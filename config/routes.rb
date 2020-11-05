Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home', as: 'homepage'

  resources :cooks, only: [:index]
  resources :baskets, only: [:show] do
    resources :cooks, only: [:show]
  end

  get 'meal_details/:id', to: 'meals#meal_details', as: 'meal_details'
  get 'new_basket', to: 'baskets#create', as: 'new_basket'
end
