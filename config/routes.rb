Rails.application.routes.draw do
  #get 'borrowings/new'

  # get 'sessions/new'

  root to: 'top_pages#home'
  get 'signup',  to: 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :items
  resources :borrowings
end
