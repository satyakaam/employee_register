Rails.application.routes.draw do
  root 'events#index'
  devise_for :users

  namespace :admins do
    resources :users, except: :show do
      resources :events, except: :show
    end
  end

  resources :events, only: [:index, :create]
end
