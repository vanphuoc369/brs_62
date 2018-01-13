Rails.application.routes.draw do
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get  "/signup", to: "users#new"
  resources :users, except: :destroy
  root "static_pages#home"
  resources :books do
    resources :user_books, only: [:create, :update]
  end
end
