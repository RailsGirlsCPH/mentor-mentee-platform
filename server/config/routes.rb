Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'api/v1/api_users#create'
  get 'welcome/index'

  namespace :api do
    namespace :v1 do
      resources :programminglanguages
      resources :meetingintervals
      resources :api_users do
        resources :wishes
        resources :experiences
    end
  end
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  end
end
