Rails.application.routes.draw do
  get '/works/new', to: 'works#new'
  post '/works/new', to: 'works#create'

  get 'works/edit'

  get 'search_works/index'

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