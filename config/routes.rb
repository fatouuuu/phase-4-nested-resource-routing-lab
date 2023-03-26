Rails.application.routes.draw do
  # resources :items, only: [:index]
  resources :users, only: [:show] do 
    resources :items, only: [:index, :show, :create]
  end
  resources :items, only: [:index, :show, :create]
  get 'items', to: 'items#index'
end
