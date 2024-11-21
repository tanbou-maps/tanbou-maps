Rails.application.routes.draw do
  # Defines the root path route ("/")
  root 'index#show'

  get 'sign-in', to: 'sessions#new'
  get 'sign-up', to: 'registration#new'
  post 'sign-up', to: 'registration#create'
  post 'sign-in', to: 'sessions#create'

  get 'spots/search', to: 'spots#search'
  get 'spots/add', to: 'spots#new'
  get 'spots/view', to: 'spots#index'

  resources :spots, only: %i[index create]
  resources :components, only: %i[index SignIn SignUp]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
