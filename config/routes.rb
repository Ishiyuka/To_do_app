Rails.application.routes.draw do
  root to: 'sessions#new'
  resources :users, only: %I[new create show edit update]
  resources :sessions, only: %I[ new create destroy]
  namespace :admin do
    resources :users
  end
  resources :tasks do
    collection do
      get :sort
    end
  end
end