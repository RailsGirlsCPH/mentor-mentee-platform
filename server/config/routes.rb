Rails.application.routes.draw do
  get 'welcome/index'

  resources :users do
    resources :experiences
  end
  resources :experiences 
  resources :languages
  #I think final state would be
  #resources :users do
  # resources :wishes
  # resoures :exp
  # resources :prog_lang
  # resources :meet_freq
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

