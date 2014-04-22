PepperMint::Application.routes.draw do

  root 'home#home'
  resources :users
  resources :accounts
  resource :session, only: [:new, :create, :destroy]
end
