Rails.application.routes.draw do
  root to: 'home#dashboard'

  # Only generate root devise routes for sessions (sign in / sign out)
  devise_for :users, only: [:passwords, :sessions], path: '', path_names: { sign_in: 'login' }

  resources :posts, only: [:index, :show]

  resource :user, only: [:edit, :update], as: 'current_user'

  #Admin Panel
  namespace :admin do
    root to: 'users#index'

    resources :users, except: :destroy
  end

  # Manage Panel
  namespace :manage do
    resources :posts, only: [:create, :index, :new]

    resources :posts, only: [:edit, :update] do
      resources :comments
    end
  end

end
