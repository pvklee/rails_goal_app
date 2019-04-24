Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root to: 'users#index'

  resource :session
  resources :users do
    resources :goals, only: [:index, :show]
  end
  resources :goals
  resources :user_comments
  resources :goal_comments
end
