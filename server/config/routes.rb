Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # post 'auth/login', to: 'authentication#authenticate'
  # devise_scope :api_user do
  #   post 'auth/login', to: 'devise/sessions#new'
  # end
  # devise_for :api_users, :skip => [:sessions, :registrations, :password], defaults: {format: :json}
  devise_for :api_users, defaults: {format: :json}
  #if you don't include password in the list above then you get some routes for password. So we are getting rid of the autogeneration with the line above, and then defining the auth routes below
  devise_scope :api_user do
    post 'login' => 'sessions#create', :as => :login
    delete 'logout' => 'sessions#delete', :as => :logout
    post 'register_user' => 'registrations#create', :as => :register
    delete 'delete_user' => 'registrations#destroy', :as => :delete_account
  end
  
  # namespace :api do
  #   namespace :v2 do
  #     # devise_for :api_users
  #     resources :api_users
  #     resources :sessions, only: [:create,:destroy] 
  #   end
  # end
end
