Rails.application.routes.draw do
  resources :parkings
  resources :customers, except: [:index] do
    resources :sources, only: [:create], controller: :sources
    resources :accounts, only: [:create]
    post :default_source, controller: :sources
  end

  resources :reservations
  resources :vehicules
  resources :charges, only: [:create]
end
