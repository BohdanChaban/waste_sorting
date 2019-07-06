Rails.application.routes.draw do

  devise_for :users
  resources :cities, only: %i[index create new show]
  root to: 'cities#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
