Rails.application.routes.draw do
  get 'comments/index'
  get 'comments/show'
  get 'comments/new'
  get 'comments/edit'
  devise_for :users

  get 'dashboard/index'

  get "friend/entries" => "entries#friends_entries"
  get "friend/entry/:id" => "entries#friend_entry_show", as: :friend_entry_show

  resources :reactions, only: [:create]

  resources :entries do
    resources :reactions, only: [:new, :create]

    collection do
      get 'dashboard'
      get 'search'
    end

  end

  get 'profile', to: 'users#show', as: 'profile'
  get 'profile/:id', to: 'users#friend_profile', as: 'friend_profile' 

  resources :friendships, only: [:index, :show] do
    collection do
      post :add_friend
      delete :remove_friend
      get :search
    end
  end

  resources :entries do
    resources :comments, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  end

  resources :users, only: [:show, :edit, :update] do
    member do
      patch :update_bio
      patch :upload_profile_picture
    end
  end

  resources :notifications, only: [:show, :edit, :update, :new, :create]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  # root to: "home#index"
  root to: "dashboard#index"
end
