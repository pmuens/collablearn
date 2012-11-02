Collablearn::Application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, except: [:new, :index]

  match '/home/:id', to: 'users#home'
  match '/login', to: 'sessions#new'
  match '/logout', to: 'sessions#destroy'
  match '/terms_of_service', to: 'static_pages#terms_of_service'
  match '/masthead', to: 'static_pages#masthead'
  match '/contact', to: 'static_pages#contact'

  root to: 'static_pages#home'
end