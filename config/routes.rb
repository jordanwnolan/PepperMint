PepperMint::Application.routes.draw do

  root 'home#home'
  get 'overview', to: 'home#overview', as: :overview
  get 'followed_feed', to: 'home#followed_feed'
  get 'feed', to: 'home#feed'

  resources :users do
    member do
      get 'follow', to: 'users#follow_user'
      get 'unfollow', to: 'users#unfollow_user'
    end
  end
  resources :accounts
  resources :budgets
  resources :goals
  resources :transactions, only: [:index, :edit, :update]
  get 'account_choose', to: 'accounts#choose', as: :account_choose
  resource :session, only: [:new, :create, :destroy]
  
end
