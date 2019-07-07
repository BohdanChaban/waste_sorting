Rails.application.routes.draw do
  resources :articles

  resources :cities, only: %i[index create new show]

  root to: 'cities#index'

end
