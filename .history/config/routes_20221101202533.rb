Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks do
    collection do
      get :sort
    end
  end
end