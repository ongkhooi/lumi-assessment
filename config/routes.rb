Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "news#index"

  resources :news, only: :index
  resources :publishers, only: [:index, :create]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check
end
