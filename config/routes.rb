Rails.application.routes.draw do
  get 'comments/index'
  get 'comments/show'
  get 'comments/new'
  get 'comments/edit'
  devise_for :users

  get 'dashboard/index'



  resources :friendships, only: [:index] do
    post :add_friend, on: :collection
    delete :remove_friend, on: :collection
  end


  resources :entries do
    resources :comments, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  end

  resources :users, only: [:show, :edit, :update]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  # root to: "home#index"
  root to: "dashboard#index"
end
