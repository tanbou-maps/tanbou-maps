Rails.application.routes.draw do
  root 'index#show'

  # サインアップ・サインイン関連
  get 'sign-in', to: 'sessions#new', as: :sign_in
  post 'sign-in', to: 'sessions#create'
  delete 'sign-out', to: 'sessions#destroy', as: :sign_out

  get 'sign-up', to: 'registration#new', as: :sign_up
  post 'sign-up', to: 'registration#create'

  # サインアップ完了後の挙動
  get 'registration/complete', to: 'registration#complete', as: 'complete_registration'
  # サインアウト後の挙動
  get 'sessions/signout', to: 'sessions#signout', as: 'signout_sessions'

  resources :components, only: %i[index SignIn SignUp]

  # スポット CRUD
  resources :spots, only: %i[new create index show] do
    collection do
      get 'search' # Keep your existing search route
    end
  end

  resources :model_courses, path: 'model-courses' do
    member do
      patch :regenerate_public_key # 公開キー再発行用ルート
    end
  end

end
