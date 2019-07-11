Rails.application.routes.draw do
  resources :districts, except: %i[index show]
  resources :accounts, except: :destroy
  resources :articles
  devise_for :users
  resources :cities, only: %i[index create new show]
  root to: 'articles#index'
end
