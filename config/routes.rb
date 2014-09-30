Rails.application.routes.draw do
  root to: 'home#dashboard'

  # Route helper to generate pretty will_paginate urls
  def pretty_pagination(action, route = 'page/:page')
    get route, action: action, on: :collection
  end

  # Only generate root devise routes for sessions (sign in / sign out)
  devise_for :users, only: [:passwords, :sessions], path: '', path_names: { sign_in: 'login' }

  resources :posts, only: [:index, :show] do
    resources :comments
  end

  resource :user, only: [:edit, :update], as: 'current_user'

  resources :users, only: [:index, :show], path: 'members' do
    pretty_pagination :index
    pretty_pagination :show, ':id/page/:page'
  end

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
