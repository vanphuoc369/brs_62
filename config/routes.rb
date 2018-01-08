Rails.application.routes.draw do
  get  "/signup",  to: "users#new"
  resources :users, except: %i(edit, update, destroy)
  root "static_pages#home"
end
