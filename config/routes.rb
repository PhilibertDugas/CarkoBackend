Rails.application.routes.draw do
  resources :parkings
  resources :customers, except: [:index] do
    resources :sources, only: [:create]
    resources :accounts, only: [:create]
    post :default_source, controller: :sources
    post :external, controller: :accounts
  end

  resources :reservations
  resources :vehicules
end
