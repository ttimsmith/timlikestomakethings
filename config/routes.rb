Rails.application.routes.draw do
  root to: 'home#dashboard'

  # Route helper to generate pretty will_paginate urls
  def pretty_pagination(action, route = 'page/:page')
    get route, action: action, on: :collection
  end

  # Devise Routes
  devise_for :users, controllers: { registrations: 'registrations' }, path: '',
    path_names: { sign_in: 'login', sign_up: 'join'}

  resources :posts, only: [:index, :show] do
    resources :comments
  end

  resources :users, only: [:index, :show], path: 'members' do
    pretty_pagination :index
    pretty_pagination :show, ':id/page/:page'
  end

  resource :user, only: [:edit, :update], as: 'current_user'

  #Admin Panel
  namespace :admin do
    root to: 'users#index'

    resources :users, except: :destroy
  end

  # Manage Panel
  namespace :manage do
    resources :posts do
      resources :comments
    end
  end



end
