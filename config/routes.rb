Rails.application.routes.draw do
  resources :tasks
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root  'tasks#index'
  scope :auth do
    get "login", to: "sessions#login", as: "login"
    post "login", to: "sessions#authenticate", as: "new_session_post"
    get "register", to: "sessions#register", as: "new_user"
    post "register", to: "sessions#create_user", as: "new_user_post"
    get "profile", to: "sessions#show_profile", as: "show_profile"
    get "profile/update", to: "sessions#profile", as: "edit_profile"
    patch "profile/update", to: "sessions#update_profile", as: "edit_profile_post"
    post "logout", to: "sessions#logout", as: "destroy_session"
  end
  scope :admin do
      get "users", to: "admin#list", as: "admin_users"
      get "/user/new", to: "admin#new", as: "new_admin_user"
      post "/user/new", to: "admin#create", as: "new_admin_user_post"
      get "/user/:id", to: "admin#show", as: "admin_user"
      get "/user/:id/edit", to: "admin#edit", as: "edit_admin_user"
      patch "/user/:id/edit", to: "admin#update_user", as: "edit_admin_user_post"
      delete "/user/:id", to: "admin#destroy", as: "delete_admin_user"
  end
end


# admin_users	Écran de liste d'utilisateurs
# nouvel_utilisateur_administrateur	Écran d'enregistrement de l'utilisateur
# utilisateur_admin	Écran de détails de l'utilisateur
# modifier_admin_user	Écran de modification de l'utilisateur