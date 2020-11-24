Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home', as: 'homepage'

  resources :cooks, only: :index

  namespace :cook_dashboard do
    resources :cooks, only: :show
    resources :orders, only: :index
  end

  resources :meals, only: :show do
    get 'details'
  end

  resources :baskets, only: :show do
    get 'create', on: :collection
    get 'total_price', on: :member
    resources :orders, only: :create
    resources :cooks, only: :show
    resources :meals, only: [] do
      get 'presence_checking'
    end
  end

  resources :users, only: :show do
    resources :orders, only: :index
    patch 'update_details'
  end

  resources :basket_suborders, only: %i[create update destroy]
end
