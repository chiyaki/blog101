Rails.application.routes.draw do
  get 'welcome/index'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  resources :blogs do
    resources :posts
  end
  namespace :account do
    resources :blogs do
      resources :posts
    end
  end
end
