Rails.application.routes.draw do
  resources :articles
  devise_for :users
  resources :cities, only: %i[index create new show]
  root to: 'articles#index'
end
