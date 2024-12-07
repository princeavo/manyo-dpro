Rails.application.routes.draw do
  resources :tasks
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root  'tasks#index'
  get "/users/:id", to: "tasks#show", as: "user"
end
