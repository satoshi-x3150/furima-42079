Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :items

  resources :items do
    resources :orders, only: [:index, :create] # ← 購入関連のルーティングをネスト
  end
  end
