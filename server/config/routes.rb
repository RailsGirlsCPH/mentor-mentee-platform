Rails.application.routes.draw do
  get 'welcome/index'

  namespace :api do
    namespace :v1 do
      resources :programminglanguages
      resources :meetingintervals
      resources :api_users do
        resources :wishes
    end
  end
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  end
end
