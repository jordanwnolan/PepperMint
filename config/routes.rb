PepperMint::Application.routes.draw do

  root 'home#home'
  get 'overview', to: 'home#overview', as: :overview
  get 'followed_feed', to: 'home#followed_feed'
  get 'feed', to: 'home#feed'


  resources :users do
    resources :messages, only: [:create, :show, :index, :destroy]
    resources :notifications, only: [:index]
    member do
      # resources :messages, only: [:create, :show, :index, :destroy]
      get 'follow', to: 'users#follow_user'
      get 'unfollow', to: 'users#unfollow_user'
      post 'share/:share_id/fame', to: 'users#fame', as: :fame
      post 'share/:share_id/shame', to: 'users#shame', as: :shame
    end
  end

  resources :fames, only: [:destroy]
  resources :accounts
  resources :budgets
  resources :goals
  resources :transactions, only: [:index, :edit, :update]
  get 'account_choose', to: 'accounts#choose', as: :account_choose
  resource :session, only: [:new, :create, :destroy]
  
end
