Rails.application.routes.draw do

  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/signup", to: "users#new"
  resources :users, except: :destroy do
    resources :buy_requests, except: %i(show edit update)
    get "following/index"
    get "followers/index"
  end
  root "static_pages#home"
  resources :books do
    resources :user_books, only: %i(create update)
    resources :reviews do
      resources :comments
    end
  end
  get "/request_books", to: "request_books#index"
  namespace :admin do
    root "static_pages#index"
    resources :users
    resources :categories
  end
  resources :relationships, only: %i(create destroy)
end
