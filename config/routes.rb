Rails.application.routes.draw do
  #get 'borrowings/new'

  # get 'sessions/new'

  # get 'borrowings/cretae' => "borrowings#create"
  
  get 'items/find_borrowing' => "items#find_borrowing"
  get 'items/found_item' => "items#found_item"
  get 'users/show_borrowing' => "users#show_borrowing"
  get 'items/item_ranking' => "items#item_ranking"
  get 'items/item_borrower_ranking' => "items#item_borrower_ranking"

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
