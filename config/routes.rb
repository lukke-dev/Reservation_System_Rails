require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout' }
  authenticate(:user, ->(user) { user.is_admin }) { mount Sidekiq::Web => '/sidekiq' }
  resources :categories, except: %i[show]
  resources :reservations, except: %i[show] do
    post :change_status
  end
  resources :books, except: %i[show] do
    collection do
      get :download_csv_template, defaults: { format: 'csv' }
      get :import
      post :import_file
    end
  end

  root 'home#index'
  get 'dashboard', to: 'home#dashboard'
  post :clean_all_notifications, to: 'notifications#clean_all'
  post '/:id/clean_notification', to: 'notifications#clean', as: :clean_notification
end
