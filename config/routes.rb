Rails.application.routes.draw do
  resources :events
  resources :parkings
  resources :customers, except: [:index] do
    resources :reservations, controller: :customer_reservations
    get :active_reservations, controller: :customer_active_reservations, only: [:index]

    resources :parkings, controller: :customer_parkings
    resources :sources, only: [:create]
    resources :accounts, only: [:create]
    resources :vehicules, except: [:index]


    post :default_source, controller: :sources
    post :external, controller: :accounts
  end
end
