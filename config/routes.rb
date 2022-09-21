require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
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
  resources :categories, except: %i[show]
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout' }

  root 'home#index'
  get 'dashboard', to: 'home#dashboard'
end
