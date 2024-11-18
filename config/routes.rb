Rails.application.routes.draw do
  # Defines the root path route ("/")
  root 'vue#index' # 'vue#index'がトップページになるように設定
  get '/', to: 'vue#index'
  get 'vue/index', to: 'vue#index'
  get 'vue/sign-in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  resources :components, only: %i[index SignIn]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
