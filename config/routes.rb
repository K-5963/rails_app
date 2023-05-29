Rails.application.routes.draw do
  get '/hello', to: 'static_pages#hello'
  get '/about', to: 'static_pages#about'
  get '/sign_up', to: 'users#new'
  post '/sign_up', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root 'static_pages#hello'
  
  
  resources :users do
    member do
      get :favorites
      get :following_users
      get :followers
      post :follow, to: 'relationships#create'
      delete :unfollow, to: 'relationships#destroy'
    end
  end
  
  resources :books do
    member do
      post :favorites, to: 'favorites#create'
      delete :favorites, to: 'favorites#destroy', as: 'destroy_favorite'
    end
  end
  
end