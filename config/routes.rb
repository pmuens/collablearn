Collablearn::Application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, except: [:new, :index]
  resources :questions, except: [:show, :index]

  match '/home/:id', to: 'users#home', as: 'home'
  match '/login', to: 'sessions#new'
  match '/logout', to: 'sessions#destroy'
  match '/terms_of_service', to: 'pages#terms_of_service'
  match '/masthead', to: 'pages#masthead'
  match '/contact', to: 'pages#contact'

  root to: 'pages#home'
end