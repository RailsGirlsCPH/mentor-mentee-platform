Rails.application.routes.draw do
  get 'welcome/index'

  namespace :api do
    namespace :v1 do
      resources :api_users
    end
  end
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

