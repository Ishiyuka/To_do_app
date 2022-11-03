Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks do
    collection do
      get :sort
      # get 'search'
    end
  end
end