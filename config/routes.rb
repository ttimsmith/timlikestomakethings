Rails.application.routes.draw do
  root to: 'home#dashboard'

  # Only generate root devise routes for sessions (sign in / sign out)
  devise_for :users, only: :sessions

  namespace :admin do
    root to: 'users#index'

    resources :users
  end

end
