Rails.application.routes.draw do
  
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  
  resources :users do
    
    collection do
      get 'unsubscribe'
      patch 'withdraw'
    end
    member do
      get :follows, :followers, :likes
    end
    resource :follows, only: [:create, :destroy]
    
  end
  
  
  resources :articles do
    
    resource :likes, only: [:create, :destroy]
    resource :article_comments, only: [:create, :destroy]
    
  end
  
  resources :tags do
    get 'articles', to: 'articles#search'
    #タグによって絞り込んだ投稿を表示するアクションへのルーティング
  end
  

  
end
