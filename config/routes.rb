Rails.application.routes.draw do
#  get 'works', to: 'works#index'
#  get '/works/new', to: 'works#new'
#  post '/works/new', to: 'works#create'
#  delete '/works/delete', to: 'works#destroy'
#  get 'works/edit'
  
  get 'search_works/index'
  get 'search_works', to: 'search_works#index'
  
  get 'sessions/new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  root 'static_pages#home'
  
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'

  resources :users
  resources :works

end 