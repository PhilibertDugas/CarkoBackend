Rails.application.routes.draw do
  resources :parkings
  resources :customers do
    resources :sources, only: [:create], controller: :sources
    post :default_source, controller: :sources
  end

  resources :reservations
  resources :charges, only: [:create]
end
