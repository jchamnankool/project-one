Rails.application.routes.draw do
  resources :follows
  root :to => "pages#home"
  get "/dashboard" => "pages#dashboard"
  resources :users
  post "/users/:id/follow", to: "users#follow", as: "follow_user"
  post "/users/:id/unfollow", to: "users#unfollow", as: "unfollow_user"
  resources :entries
  resources :hearts, :only => [:create, :destroy]
  # logging in
  get "/login" => "session#new"
  post "/login" => "session#create"
  # logging out
  delete "/login" => "session#destroy"
end
