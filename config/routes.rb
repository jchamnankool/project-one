Rails.application.routes.draw do
  root :to => "pages#home"
  resources :users, :only => [:new, :create, :index]
  resources :entries, :only => [:new, :create, :show]
  # logging in
  get "/login" => "session#new"
  post "/login" => "session#create"
  delete "/login" => "session#destroy"
end
