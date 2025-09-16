Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    namespace :v1 do
      namespace :me do
        # resources :sleeps, only: [:create, :update, :index]
        resources :follows, only: [:index, :create, :destroy]
        resources :sleeps, only: [:index, :create, :update]
      end

      resource :me, only: [:show] do
        get :following_sleeps
      end

      resources :followers, only: [:show] do
        resources :sleeps, only: [:index], module: :followers
      end
    end
  end

  get "docs/api", to: "docs#api"
end
