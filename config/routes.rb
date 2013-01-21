Collablearn::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :users
  resources :collections do
    resources :questions
  end

  match '/:id/follow_user/:followed_id', to: 'users#follow_user', as: 'follow_user'
  match '/:id/unfollow_user/:followed_id', to: 'users#unfollow_user', as: 'unfollow_user'
  match '/:id/follow_collection/:collection_id', to: 'users#follow_collection', as: 'follow_collection'
  match '/:id/unfollow_collection/:collection_id', to: 'users#unfollow_collection', as: 'unfollow_collection'
  
  match '/home/:id', to: 'users#home'
  match '/settings/:id', to: 'users#settings', as: 'settings'
  match '/learncenter/:id', to: 'users#learncenter', as: 'learncenter'
  match '/fellowships/users/user/:id', to: 'users#fellowships_users', as: 'fellowships_users'
  match '/update_password/:id', to: 'users#update_password'

  match '/terms_of_service', to: 'pages#terms_of_service'
  match '/masthead', to: 'pages#masthead'
  match '/privacy', to: 'pages#privacy'
  match '/search', to: 'pages#search'
  match '/learn/collection/:id', to: 'pages#learn', as: 'learn'

  match '/feedback', to: 'feedbacks#create'

  root to: 'pages#index'
end