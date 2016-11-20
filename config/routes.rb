Rails.application.routes.draw do

  get 'search_works', to: 'search_works#index'

  get '/works/new', to: 'works#new'

  get '/works/edit', to: 'works#edit'

  get 'sessions/new'

  root 'static_pages#home'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :works

end 