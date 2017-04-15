Rails.application.routes.draw do
  resources :events
  resources :parkings
  resources :customers, except: [:index] do
    resources :sources, only: [:create]
    resources :accounts, only: [:create]
    resources :vehicules, except: [:index]
    post :default_source, controller: :sources
    post :external, controller: :accounts
  end

  resources :reservations
end
