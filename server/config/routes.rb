Rails.application.routes.draw do
  get 'welcome/index'

  resources :users do
    resources :experiences
    resources :wishes
  end
  resources :experiences
  resources :wishes 
  resources :programminglanguages
  resources :meetingfreqs

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

