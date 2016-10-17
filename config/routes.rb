Rails.application.routes.draw do
  resources :parkings
  resources :customers do
    member do
      post :sources
      post :default_source
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
