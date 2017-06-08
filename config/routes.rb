Rails.application.routes.draw do
  resources :events do
    resources :parkings, controller: :event_parkings, only: [:index]
  end

  resources :parkings

  resources :customers, except: [:index] do
    resources :reservations, controller: :customer_reservations
    resource 'active_reservations', action: 'index', controller: :customer_active_reservations

    resources :parkings, controller: :customer_parkings
    resources :sources, only: [:create]
    resources :accounts, only: [:create]
    resources :vehicules, except: [:index]


    post :default_source, controller: :sources
    post :external, controller: :accounts
  end
end
