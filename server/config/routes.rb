Rails.application.routes.draw do
  get 'welcome/index'

  resources :users do
    resources :experiences
    resources :wishes
  end
  resources :experiences
  resources :wishes 
  resources :programminglanguages
  namespace :api do
    namespace :v1 do
      resources :programminglanguages
    end
  end
  resources :meetingfreqs

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

