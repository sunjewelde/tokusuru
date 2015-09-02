Rails.application.routes.draw do
  root to: 'top_pages#home'
  get 'signup',  to: 'users#new'

  resources :users
end
