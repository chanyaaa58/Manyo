Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :labels
  end

  root 'tasks#index'
  resources :tasks
  resources :users
  resources :sessions
end