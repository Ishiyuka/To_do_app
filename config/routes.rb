Rails.application.routes.draw do
  resources :users, only: %I[new create show edit update]
  resources :sessions, only: %I[ new create destroy]
  namespace :admin do
    resources :users
  end
  root to: 'tasks#index'
  resources :tasks do
    collection do
      get :sort
      # get 'search'
    end
  end
end