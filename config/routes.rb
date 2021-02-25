Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks
  resources :users, only: [:new, :create, :show, :edit, :update]
  namespace :admin do
    resources :users, only: [:index, :new, :create, :show,  :edit, :destroy]
  end
  resources :sessions, only: [:new, :create, :destroy]
end
