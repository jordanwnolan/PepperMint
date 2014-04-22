PepperMint::Application.routes.draw do

  root 'home#home'
  resources :users
  resources :accounts
  resources :transactions, only: [:index]
  get 'account_choose', to: 'accounts#choose', as: :account_choose
  resource :session, only: [:new, :create, :destroy]
end
