Rails.application.routes.draw do
  get '/hello', to: 'static_pages#hello'
  get '/about', to: 'static_pages#about'
  root 'static_pages#hello'
end