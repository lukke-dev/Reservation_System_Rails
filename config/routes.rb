Rails.application.routes.draw do
  resources :reservations, except: %i[show]
  resources :books, except: %i[show]
  resources :categories, except: %i[show]
  devise_for :users, controllers: { registrations: 'users/registrations' }, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout' }

  root 'home#index'
end
