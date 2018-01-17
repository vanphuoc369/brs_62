Rails.application.routes.draw do
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get  "/signup", to: "users#new"
  resources :users, except: :destroy
  root "static_pages#home"
  resources :books do
    resources :reviews
    resources :user_books, only: %i(create update)
  end
  namespace :admin do
    root "static_pages#index"
  end
end
