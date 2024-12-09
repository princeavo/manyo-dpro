Rails.application.routes.draw do
  resources :tasks
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root  'tasks#index'
  get "/auth/login", to: "sessions#login", as: "new_session"
  get "/auth/register", to: "sessions#register", as: "new_user"
  post "/auth/register", to: "sessions#create_user", as: "new_user_post"
  get "/auth/profile", to: "sessions#profile", as: "user"
  get "/auth/profile/update", to: "sessions#update_profile", as: "edit_user"
  get "/auth/logout", to: "sessions#logout", as: "destroy_session"
end
