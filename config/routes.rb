Rails.application.routes.draw do
  root 'index#show'

  # サインアップ・サインイン関連
  get 'sign-in', to: 'sessions#new'
  post 'sign-in', to: 'sessions#create'
  get 'sign-up', to: 'registration#new'
  post 'sign-up', to: 'registration#create'
  get 'sign-out', to: 'sessions#delete'

  # ユーザープロフィール
  resources :user_profile, only: %i[new create show] do
    collection do
      post :upload_background_picture
      post :upload_profile_picture
      patch :update_nickname
      patch :update_text
      delete :destroy_account
    end
  end

  get 'user-profile-view/:id', to: 'user_profile#profileviewid'
  get 'user-profile-crud', to: 'user_profile#new'
  get 'user-profile-view', to: 'user_profile#profileview'

  # 企業プロフィール
  resources :corporate_profile, only: %i[new create show] do
    collection do
      post :upload_background_picture
      post :upload_profile_picture
      patch :update_nickname
      patch :update_text
      delete :destroy_account
    end
  end

  get 'corporate-profile-crud', to: 'corporate_profile#new'
  get 'corporate-profile-view', to: 'corporate_profile#profileview'
  get 'corporate-profile-view/:id', to: 'corporate_profile#profileviewid'

  # サインアップ完了後の挙動
  get 'registration/registration-success', to: 'registration#complete', as: 'complete_registration'
  # サインアウト後の挙動
  get 'sessions/signout', to: 'sessions#signout', as: 'signout_sessions'

  # コンポーネント
  get 'components/sign_in', to: 'components#sign_in'
  get 'components/sign_up', to: 'components#sign_up'
  resources :components, only: %i[index]

  # スポット CRUD
  resources :spots, only: %i[new create index show] do
    resources :reviews, only: %i[index new create show destroy] # destroyを追加
    collection do
      get 'search'
    end
  end

  # モデルコース
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

  # お問い合わせ-利用規約
  get '/contacts/terms', to: 'contacts#terms'
end
