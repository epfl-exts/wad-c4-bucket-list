Rails.application.routes.draw do
  root to: "home#index"

  get "login", to: "sessions#new"
  get "signup", to: "users#new"

  get 'home/index'

  get 'styles/atoms'

  get 'styles/molecules'

  get 'styles/organisms'

  resources :ideas do
    resources :comments
  end

  resources :users, only: %i(new create edit update) do
    resources :goals
  end

  resources :sessions, only: %i(new create destroy)

  get 'account', to: 'account#edit'
  patch 'account', to: 'account#update'
  get 'account/ideas'
  get 'account/goals'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
