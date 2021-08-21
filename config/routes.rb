Rails.application.routes.draw do

  resources :posts, only: [:index, :show, :create]
  devise_for :users

  root to: 'pages#home'

  resources :searches, only: [ :new, :create]

end
