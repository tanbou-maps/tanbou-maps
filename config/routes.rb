Rails.application.routes.draw do
  # Defines the root path route ("/")
  get '/', to: 'index#index'
  get 'sign-in', to: 'sessions#new'
  post 'sign-in', to: 'sessions#create'
  resources :components, only: %i[index SignIn]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
