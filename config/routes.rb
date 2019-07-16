Rails.application.routes.draw do
  resources :abouts, only: %i[index edit update]
  resources :accounts, except: :destroy
  resources :articles

  devise_for :users, controllers: { registrations: 'registrations' }
  resources :cities, only: %i[index create new show] do
    resources :districts, except: %i[index show]
  end

  root to: 'articles#index'
end
