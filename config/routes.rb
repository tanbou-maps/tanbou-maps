Rails.application.routes.draw do
  root 'index#show'

  # サインアップ・サインイン関連
  get 'sign-in', to: 'sessions#new', as: :sign_in
  post 'sign-in', to: 'sessions#create'
  delete 'sign-out', to: 'sessions#destroy', as: :sign_out

  get 'sign-outpost', to: 'sessions#destroypost'
  get 'sign-up', to: 'registration#new', as: :sign_up
  post 'sign-up', to: 'registration#create'

  # サインアップ完了後の挙動
  get 'registration/complete', to: 'registration#complete', as: 'complete_registration'
  # サインアウト後の挙動
  get 'sessions/signout', to: 'sessions#signout', as: 'signout_sessions'
  post 'sign-in', to: 'sessions#create'

  resources :components, only: %i[index SignIn SignUp]

  resources :spots, only: %i[new create index show] do
    collection do
      get 'search' # Keep your existing search route
    end
  end
  # # モデルコース
  resources :model_courses, only: [:index], path: 'model-courses'
end
