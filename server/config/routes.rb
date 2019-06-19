Rails.application.routes.draw do
  get 'welcome/index'

  resources :users do
  end
  namespace :api do
    namespace :v1 do
      resources :users
    end
  end
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

