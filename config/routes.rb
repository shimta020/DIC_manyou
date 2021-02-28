Rails.application.routes.draw do
  get 'labels/new'
  root to: 'tasks#index'
  resources :tasks
  resources :users, only: [:new, :create, :show, :edit, :update]
  namespace :admin do
    resources :users
  end
  resources :sessions, only: [:new, :create, :destroy]
end
