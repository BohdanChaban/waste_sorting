Rails.application.routes.draw do
  resources :timeslots
  resources :inquiries, except: %i[new]
  resources :contacts, except: :show
  resources :abouts, only: %i[index edit update]
  resources :accounts, except: :destroy
  resources :articles

  devise_for :users, controllers: { registrations: 'registrations' }

  namespace :admin do
    get '', to: 'dashboard#index', as: '/'
    resources :users
  end
  resources :cities, only: %i[index create new show] do
    resources :districts, except: %i[index show]
  end

  root to: 'articles#index'
end
