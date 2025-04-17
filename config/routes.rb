
require "sidekiq/web"
Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
mount Rswag::Api::Engine => '/api-docs'

  
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions" }

  resources :posts do
    resources :comments, only: [ :create, :destroy ]
    resources :likes, only: [ :create, :destroy ] # Add destroy for unliking
  end

  resources :comments do
    resources :likes, only: [ :create, :destroy ]
  end

  # get "profile", to: "users#profile"
  # Custom profile update route
  resource :profile, only: [:show, :update], controller: 'users', action: :profile
  patch 'profile/update', to: 'users#update_profile', as: :update_profile

  resources :reports, only: [ :index ] do
    collection do
      get "download_report"
    end
  end

  resources :manage_users, only: [ :index, :create, :new , :destroy] do
    member do
      patch "toggle_status", to: "manage_users#toggle_status"
    end
    collection do
      get "upload"         # Display the upload form
      post "upload_users"  # Handle the CSV/XLSX upload
    end
  end

  # Add users resource
  resources :users, only: [:index, :show, :edit, :update]

  root "home#index"

  namespace :api do
    namespace :v1 do
      resources :posts
    end
  end
  
end


