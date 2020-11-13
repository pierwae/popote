Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home', as: 'homepage'

  resources :cooks, only: [:index]
  resources :baskets, only: [:show] do
    resources :cooks, only: [:show]
  end

  get 'meal_details/:id', to: 'meals#meal_details', as: 'meal_details'

  get 'new_basket', to: 'baskets#create', as: 'new_basket'
  get 'meals/:meals_id/baskets/:id', to: 'baskets#the_meal_in_the_basket?', as: 'is_the_meal_in_the_basket'

  # post 'new_suborder', to: 'suborders#create', as: 'new_suborder'
  resources :suborders, only: [:create, :update]
end
