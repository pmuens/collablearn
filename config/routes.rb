Collablearn::Application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :users

  match '/home', to: 'users#home'
  match '/terms_of_service', to: 'static_pages#terms_of_service'
  match '/login', to: 'sessions#new'
  match '/logout', to: 'sessions#destroy'

  root to: 'static_pages#home'
end