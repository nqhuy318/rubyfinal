Rails.application.routes.draw do
  get 'categories/index'

  get 'category/index'

  get 'take-test/:id', to:'take_test#index'
  post 'take-test/:id', to:'take_test#create'
  
  get 'joiners/new'

  # get 'joiners/edit'

  get 'joiners/delete'

  #  get 'works', to: 'works#index'
  #  get '/works/new', to: 'works#new'
  #  post '/works/new', to: 'works#create'
  #  delete '/works/delete', to: 'works#destroy'
  #  get 'works/edit'
  
  get 'search_works/index'
  get 'search_works', to: 'search_works#index'
  post 'search_works', to: 'search_works#advance'
  
  get 'sessions/new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  root 'static_pages#home'
  
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  get '/edit/:id', to: 'users#edit'
  resources :users
  resources :works
  resources :joiners
  resources :categories
#  resources :take
end