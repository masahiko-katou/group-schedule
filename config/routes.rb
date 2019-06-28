Rails.application.routes.draw do
  root to: 'schedules#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'todaiphil', to: 'users#new'
  
  resources :users, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :schedules do
    member do
      get :section
      get :whole
      get :piece_1
      get :piece_2
      get :piece_3
    end
  end
  resources :answers, only: [:new, :create, :destroy, :update, :edit]
end
