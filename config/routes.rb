Rails.application.routes.draw do
  get 'vue/index', to: 'vue#index'
  get 'vue/sign-in', to: 'sessions#new'
  resources :components, only: %i[index SignIn]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
