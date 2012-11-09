Collablearn::Application.routes.draw do
  devise_for :users

  resources :users
  resources :collections do
    resources :questions
  end

  match '/follow/user/:id', to: 'users#follow_user', as: 'follow_user'
  match '/unfollow/user/:id', to: 'users#unfollow_user', as: 'unfollow_user'
  match '/follow/collection/:id', to: 'users#follow_collection', as: 'follow_collection'
  match '/unfollow/collection/:id', to: 'users#unfollow_collection', as: 'unfollow_collection'
  
  match '/home/:id', to: 'users#home'
  match '/settings/:id', to: 'users#settings', as: 'settings'
  match '/fellowships/users/user/:id', to: 'users#fellowships_users', as: 'fellowships_users'
  match '/update_password', to: 'users#update_password'

  match '/terms_of_service', to: 'pages#terms_of_service'
  match '/masthead', to: 'pages#masthead'
  match '/contact', to: 'pages#contact'
  match '/search', to: 'pages#search'

  root to: 'pages#index'
end