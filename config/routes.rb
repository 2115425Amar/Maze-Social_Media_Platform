require "sidekiq/web"
Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  devise_for :users, controllers: {registrations: "users/registrations", sessions: "users/sessions" }
  # GET /users/sign_in → login form
  # POST /users/sign_in → login
  # DELETE /users/sign_out → logout
  # GET /users/sign_up → sign up form
  # POST /users → register
  # PATCH /users → update registration
  # GET /users/edit → edit profile

  resources :posts do
    resources :comments, only: [ :create, :destroy ]
    resources :likes, only: [ :create, :destroy ] # Add destroy for unliking
  end

  # POST /posts/:post_id/comments → comments#create
  # DELETE /posts/:post_id/comments/:id → comments#destroy
  # POST /posts/:post_id/likes → likes#create
  # DELETE /posts/:post_id/likes/:id → likes#destroy

  resources :comments do
    resources :likes, only: [ :create, :destroy ]
  end
  # POST /comments/:comment_id/likes → likes#create
  # DELETE /comments/:comment_id/likes/:id → likes#destroy

  resource :profile, only: [:show, :update], controller: 'users', action: :profile
  patch 'profile/update', to: 'users#update_profile', as: :update_profile
  # GET /profile → users#show (acts as profile)
  # PATCH /profile → users#update
  # PATCH /profile/update → users#update_profile

  resources :reports, only: [ :index ] do
    collection do
      get "download_report"
    end
  end
  # GET /reports → reports#index
  # GET /reports/download_report → reports#download_report

  resources :manage_users, only: [ :index, :create, :new , :destroy] do
    member do
      patch "toggle_status", to: "manage_users#toggle_status"
    end
    collection do
      get "upload"         # Display the upload form
      post "upload_users"  # Handle the CSV/XLSX upload
    end
  end
  # GET /manage_users → manage_users#index
  # POST /manage_users → manage_users#create
  # GET /manage_users/new → manage_users#new
  # DELETE /manage_users/:id → manage_users#destroy
  # PATCH /manage_users/:id/toggle_status → manage_users#toggle_status
  # GET /manage_users/upload → manage_users#upload
  # POST /manage_users/upload_users → manage_users#upload_users



  # Add users resource
  resources :users, only: [:index, :show, :edit, :update]
  # GET /users → users#index
  # GET /users/:id → users#show
  # GET /users/:id/edit → users#edit
  # PATCH /users/:id → users#update




  namespace :api do
    namespace :v1 do
      resources :posts
      # resources :registrations, only: [:create]
      get 'users/report_users', to: 'users#report_users'
      namespace :users do
        resources :registrations, only: [:create]
        post 'login', to: 'sessions#create'         # Login
        delete 'logout', to: 'sessions#destroy'     # Logout
        # resources :sessions, only: [:create, :destroy]
      end
    end
  end

  # namespace :api do
  #   devise_scope :user do
  #     post 'login', to: 'users/sessions#create'
  #     delete 'logout', to: 'users/sessions#destroy'
  #   end
  # end
  

  # get 'api/v1/users/registrations/test', to: 'api/v1/users/registrations#test'



  # http://localhost:3000/sidekiq
  mount Sidekiq::Web => "/sidekiq"
  
  root "home#index"

end