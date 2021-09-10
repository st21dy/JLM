Rails.application.routes.draw do
  
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  
  resources :users, only: [:show, :edit, :update] do
    resource :follows, only: [:create, :destroy]
    get 'followings' => 'follows#followings', as: 'followings'
  get 'followers' => 'follows#followers', as: 'followers'
  end
  
  
  resources :articles do
    resource :likes, only: [:create, :destroy]
  end
  
  
  
end
