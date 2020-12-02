Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home', as: 'homepage'

  resources :cooks, only: :index

  namespace :cook_dashboard do
    resources :cooks, only: :show
    resources :orders, only: %i[index update] do
      patch 'accept'
      patch 'decline'
      patch 'cancel'
    end
    resources :categories, except: %i[show edit]
  end

  resources :meals, only: %i[update new create] do
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
    resources :orders, only: :index do
      patch 'accept'
    end
    patch 'update_details'
  end

  resources :basket_suborders, only: %i[create update destroy]
end
