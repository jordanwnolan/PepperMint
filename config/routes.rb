PepperMint::Application.routes.draw do

  root 'home#home'
  get 'overview', to: 'home#overview', as: :overview
  resources :users
  resources :accounts
  resources :budgets
  resources :transactions, only: [:index, :edit, :update]
  get 'account_choose', to: 'accounts#choose', as: :account_choose
  resource :session, only: [:new, :create, :destroy]
  
end
