PepperMint::Application.routes.draw do

  root 'home#home'
  get 'overview', to: 'home#overview', as: :overview
  get 'followed_feed', to: 'home#followed_feed'
  get 'feed', to: 'home#feed'
  get 'demo_user', to: 'home#demo_user'


  resources :transaction_categories, only: [:show]

  resources :users do
    resources :messages, only: [:create, :show, :index, :destroy]
    resources :notifications, only: [:index]
    member do
      get 'follow', to: 'users#follow_user'
      get 'unfollow', to: 'users#unfollow_user'
      post 'share/:share_id/fame', to: 'users#fame', as: :fame
      post 'share/:share_id/shame', to: 'users#shame', as: :shame
    end
  end

  resources :notifications, only: [:show]
  resources :fames, only: [:destroy]
  resources :comments, only: [:destroy]
  resources :accounts do
    resources :transaction_categories, only: [:show]
  end
  resources :budgets do
    resources :comments, only: [:create]
  end
  resources :goals do
    resources :comments, only: [:create]
  end
  resources :transactions, only: [:index, :edit, :update]
  get 'account_choose', to: 'accounts#choose', as: :account_choose
  resource :session, only: [:new, :create, :destroy]
  
end
