Rails.application.routes.draw do
  root :to => "pages#home"
  get "/dashboard" => "pages#dashboard"
  resources :users, :only => [:new, :create, :index, :show]
  patch "users/follow" => "users#follow"
  patch "users/unfollow" => "users#unfollow"
  resources :entries
  resources :hearts, :only => [:create, :destroy]
  # logging in
  get "/login" => "session#new"
  post "/login" => "session#create"
  # logging out
  delete "/login" => "session#destroy"
end
