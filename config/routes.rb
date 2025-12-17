Rails.application.routes.draw do
  devise_for :users
  
  root "home#index"
  
  authenticated :user do
    root "dashboard#index", as: :authenticated_root
  end

  resources :cryptocurrencies, only: [:index, :show], param: :symbol
  resources :portfolios, only: [:index, :show]
  resources :transactions, only: [:index, :create, :new]
  resources :price_alerts, only: [:index, :create, :destroy]
  
  get "dashboard", to: "dashboard#index", as: :dashboard

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
