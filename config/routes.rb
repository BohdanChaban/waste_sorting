Rails.application.routes.draw do

  resources :articles

  resources :cities, only: %i[index create new show]

  root to: 'cities#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'articles#index'
end
