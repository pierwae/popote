Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home', as: 'homepage'

  resources :cooks, only: [:index]
  resources :baskets, only: [:show] do
    resources :cooks, only: [:show]
  end

  get 'meal_details/:id', to: 'meals#meal_details', as: 'meal_details'

  get 'new_basket', to: 'baskets#create', as: 'new_basket'
  get 'basket_total_price/:id', to: 'baskets#total_price'
  get 'meals/:meals_id/baskets/:id', to: 'baskets#the_meal_in_the_basket?', as: 'is_the_meal_in_the_basket'

  resources :suborders, only: [:create, :update, :destroy]

  get 'account', to: 'users#show', as: 'account'
  patch 'update_user_details/:id', to: 'users#update_details', as: 'update_user_details'
  patch 'update_user_address/:id', to: 'users#update_address', as: 'update_user_address'
end
