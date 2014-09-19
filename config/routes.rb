Rails.application.routes.draw do
#devise_for :users
devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get '/books/search' => 'books#search'
  resources :books, only: [:index, :create, :update, :show, :destroy] do
    member do
      get  :reviews
      post :review
      post :recommend
    end
  end

  resources :users, only: [:index] do
    member do
      post :friend
      post :unfriend
    end
  end

  resources :bookshelves, only: [:index, :create, :destroy]

  get '/friends'         => 'users#friends'
  get '/recommendations' => 'books#recommendations'

  root to: "static_pages#home"
end
