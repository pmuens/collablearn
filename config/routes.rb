Collablearn::Application.routes.draw do
  devise_for :users

  resources :questions, except: [:show, :index]
  resources :users, only: [:show, :edit, :update]

  match '/home/:id', to: 'users#home'
  match '/terms_of_service', to: 'pages#terms_of_service'
  match '/masthead', to: 'pages#masthead'
  match '/contact', to: 'pages#contact'

  root to: 'pages#index'
end