Rails.application.routes.draw do

  resources :posts, only: [:index, :show]
  devise_for :users

  root to: 'pages#home'
  get 'index', to: 'posts#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
