Rails.application.routes.draw do
  resources :accounts, except: :destroy
  resources :articles
  devise_for :users
  resources :cities, only: %i[index create new show]
  root to: 'articles#index'
end
