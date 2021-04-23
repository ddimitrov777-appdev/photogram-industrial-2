Rails.application.routes.draw do
  
  root "photos#index"

  #get “/users/:id”  => "users#show", as: :user

 
  devise_for :users

  resources :comments
  resources :follow_requests
  resources :likes
  resources :photos
  resources :users, show: :only
  
  
  get ":username" => "users#show", as: :user
  get ":username/liked" => "users#liked", as: :liked
  get ":username/feed" => "users#feed", as: :feed
  get ":username/discover" => "users#discover", as: :discover
  get ":username/followers" => "users#followers", as: :followers
  get ":username/following" => "users#following", as: :following

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
