Rails.application.routes.draw do
  

  resources :users do
    resources :goals, only: [:new, :create, :index]
  end
  
  resources :goals, only: [:show, :destroy, :edit]
  resource :session
end
