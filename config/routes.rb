Rails.application.routes.draw do
  root 'index#show'

  # サインアップ・サインイン関連
  get 'sign-in', to: 'sessions#new', as: :sign_in
  post 'sign-in', to: 'sessions#create'
  delete 'sign-out', to: 'sessions#destroy', as: :sign_out

  get 'sign-outpost', to: 'sessions#destroypost'
  get 'sign-up', to: 'registration#new', as: :sign_up
  post 'sign-up', to: 'registration#create'

  # ユーザープロフィール
  resources :user_profile, only: %i[new create] do
    collection do
      post :upload
      post :upload_profile_picture
      post :update_text
    end

    member do
      patch :update_nickname
      delete :destroy_account # アカウント削除のルートを追加
    end
  end

  # 企業プロフィール
  resources :corporate_profile, only: %i[new create] do
    collection do
      post :upload
    end

    member do
      patch :update_nickname
    end
  end

  get 'corporate-profile-crud', to: 'corporate_profile#new'
  get 'corporate-profile-view', to: 'corporate_profile#view'

  get 'user-profile-view', to: 'user_profile#view'
  get 'user-profile-crud', to: 'user_profile#new'
  # get 'user-prifile-crud', to: 'user_profile#upload'
  # サインアップ完了後の挙動
  get 'registration/registration-success', to: 'registration#complete', as: 'complete_registration'
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

  # お問い合わせ contact
  resources :contacts, only: %i[new create] do
    collection do
      get 'complete'
    end
  end
end
