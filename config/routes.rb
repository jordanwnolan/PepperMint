PepperMint::Application.routes.draw do

  # root 'welcome#index'
  resources :users
  resource :session, only: [:new, :create, :destroy]
end
