Rails.application.routes.draw do
  get '/hello', to: 'static_pages#hello'
  get '/about', to: 'static_pages#about'
  get '/sign_up', to: 'users#new'
  post '/sign_up', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root 'static_pages#hello'
  
  get '/users/:id/favorites', to: 'users#favorites', as: 'favorited_books'
  post '/books/:id/favorites', to: 'favorites#create', as: 'create_favorite'
  delete '/books/:id/favorites', to: 'favorites#destroy', as: 'destroy_favorite'
  
  resources :users
  resources :books
end