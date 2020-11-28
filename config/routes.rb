Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  namespace :merchant do
    get "/", to: 'dashboard#show'
    get "/items", to: 'dashboard#index'
    get '/items/new', to: 'dashboard#new'
    post '/items', to: 'dashboard#create'
    get '/items/:item_id/edit', to: 'dashboard#edit'
    get '/orders/:order_id', to: 'dashboard#order'
    patch 'orders/:order_id', to: 'dashboard#fulfill_order'
    patch '/items/:item_id/update', to: 'dashboard#update'
    patch '/items/:item_id/disable', to: 'dashboard#disable'
    patch '/items/:item_id/activate', to: 'dashboard#activate'
    delete '/items/:item_id/delete', to: 'dashboard#destroy'
  end

  namespace :admin do
    get '/', to: 'dashboard#index'
    get '/users', to: 'dashboard#users_index'
    get '/users/:user_id', to: 'dashboard#users_show'
    patch '/:order_id', to: 'dashboard#ship'
    get '/merchants', to: 'dashboard#merchant_index'
    patch '/merchants/:merchant_id/disable', to: 'dashboard#disable'
    patch '/merchants/:merchant_id/enable', to: 'dashboard#enable'
    get '/merchants/:merchant_id', to: 'dashboard#merchant'
  end

  # resources :merchants do
  #   resources :items, only: [:index, :new, :create]
  # end

  get "/merchants", to: "merchants#index"
  get "/merchants/new", to: "merchants#new"
  get "/merchants/:id", to: "merchants#show"
  post "/merchants", to: "merchants#create"
  get "/merchants/:id/edit", to: "merchants#edit"
  patch "/merchants/:id", to: "merchants#update"
  delete "/merchants/:id", to: "merchants#destroy"

  # resources :items, except: [:new, :create]
  get "/items", to: "items#index"
  get "/items/:id", to: "items#show"
  get "/items/:id/edit", to: "items#edit"
  patch "/items/:id", to: "items#update"
  get "/merchants/:merchant_id/items", to: "items#index"
  get "/merchants/:merchant_id/items/new", to: "items#new"
  post "/merchants/:merchant_id/items", to: "items#create"
  delete "/items/:id", to: "items#destroy"

  # Tried to make this work. the two routes under here are what we tried to generate
  resources :items do
    resources :reviews, only: [:new, :create]
  end
  # get "/items/:item_id/reviews/new", to: "reviews#new"
  # post "/items/:item_id/reviews", to: "reviews#create"

  # resources :reviews, only: [:edit, :update, :destroy]
  get "/reviews/:id/edit", to: "reviews#edit"
  patch "/reviews/:id", to: "reviews#update"
  delete "/reviews/:id", to: "reviews#destroy"

  post "/cart/:item_id", to: "cart#add_item"
  patch "/cart/:item_id/add", to: 'cart#add_quantity'
  patch "cart/:item_id/sub", to: 'cart#sub_quantity'
  get "/cart", to: "cart#show"
  delete "/cart", to: "cart#empty"
  delete "/cart/:item_id", to: "cart#remove_item"

  # resources :orders, only: [:new, :create, :show]

  get "/orders/new", to: "orders#new"
  post "/orders", to: "orders#create"
  get "/orders/:id", to: "orders#show"

  # resources :users, only: [:create]

  post "/users", to: "users#create", as: "users"

  get "/register", to: "users#new"
  get "/profile", to: "users#show"
  get "/profile/edit", to: "users#edit"
  patch "/profile", to: 'users#update'
  get "/profile/edit_password", to: 'users#edit_password'
  patch "/profile/update_password", to: 'users#update_password'
  get '/profile/orders', to: 'users#orders'
  get '/profile/orders/:id', to: 'orders#show'
  patch '/profile/orders/:id', to: "orders#cancel"

  get "/login", to: 'sessions#new'
  post "/login", to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
