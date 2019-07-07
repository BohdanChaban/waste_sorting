Rails.application.routes.draw do
  devise_for :users
  resources :cities, only: %i[index create new show]
  resources :articles
  root to: 'cities#index'
end
