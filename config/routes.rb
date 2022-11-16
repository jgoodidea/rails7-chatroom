Rails.application.routes.draw do
  # get 'users/show'
  resources :rooms do
    resources :messages
    collection do
      post :search
    end
  end
  # leave_room_path(room)
  get 'rooms/leave/:id', to: 'rooms#leave', as: 'leave_room'
  # join_room_path(room)
  get 'rooms/join/:id', to: 'rooms#join', as: 'join_room'

  root 'pages#home'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # devise_scope :user do
  #   get 'users', to: 'devise/sessions#new'
  # end
  get 'user/:id', to: 'users#show', as: 'user'

  # Defines the root path route ("/")
  # root "articles#index"
end
