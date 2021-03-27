Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  post 'auth/login', to: 'authentication#authenticate'

  namespace :api do
    namespace :v1 do
      post 'signup', to: 'api_users#create'
      resources :programminglanguages
      resources :meetingintervals
      resource :profile do
        resources :wishes
        resources :experiences
      end
      resources :api_users, only: %i[index create show] do
        resources :wishes, only: %i[index show]
        resources :experiences, only: %i[index show]
      end
    end

    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  end
end
