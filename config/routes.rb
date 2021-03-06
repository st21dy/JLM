Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }
  
  resources :news, only: [:create, :index, :show, :destroy]
  
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get '/about', to: "homes#about"

  resources :users do
    collection do
      get 'unsubscribe'
      patch 'withdraw'
      get 'search'
    end
    member do
      get :follows, :followers, :likes
    end
    resource :follows, only: [:create, :destroy]
  end

  resources :articles do
    resource :likes, only: [:create, :destroy]
    resource :article_comments, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end

  get '/article/hashtag/:name', to: "articles#hashtag"
  
end
