Rails.application.routes.draw do
  
  
  resources :characterizations
  resources :genres
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root "movies#index"

  get "movies/filter/:filter" => "movies#index", as: :filtered_movies

  resources :movies do
    resources :reviews
    resources :favorites, only: [:create, :destroy]
  end

  resources :users

  get "signup" => "users#new"

  resource :session, only: [:new, :create, :destroy]
  get "signin" => "sessions#new"

  #get "movies" => "movies#index"
  #get "movies/:id" => "movies#show", as: "movie"
  #get "movies/:id/edit" => "movies#edit", as: "edit_movie"
  #patch "movies/:id" => "movies#update"


end
