Rails.application.routes.draw do
  root to: 'home#dashboard'

  # Only generate root devise routes for sessions (sign in / sign out)
  devise_for :users, only: [:passwords, :sessions], path: '', path_names: { sign_in: 'login' }

  resources :posts, only: [:index, :show]

  namespace :admin do
    root to: 'users#index'

    resources :users, except: :destroy
  end

  namespace :manage do
    resources :posts, except: :destroy
  end

end
