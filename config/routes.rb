Rails.application.routes.draw do
  root 'index#show'

  # サインアップ・サインイン関連
  get 'sign-in', to: 'sessions#new'
  post 'sign-in', to: 'sessions#create'
  get 'sign-up', to: 'registration#new'
  post 'sign-up', to: 'registration#create'
  get 'sign-up-complete', to: 'registration#complete'
  get 'sign-out', to: 'sessions#destroy'

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

  get 'user-profile-view/:id', to: 'user_profile#profile_view_id'
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
  get 'user-profile-view', to: 'user_profile#profile_view'

  # スポット CRUD
  resources :spots, only: %i[new create index show] do
    resources :reviews, only: %i[index new create show destroy]
    collection do
      get :search
    end
  end

  # モデルコース
  resources :model_courses, path: 'model-courses', param: :record_uuid do
    member do
      patch :update
      delete :destroy
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

  # 管理者　admin
  get 'admin', to: 'admin/base#index', as: :admin_dashboard
  namespace :admin do
    # コンテンツ管理
    get 'contents', to: 'contents/dashboard#index', as: :contents_dashboard
    namespace :contents do
      resources :spots, only: %i[index new create edit update destroy show] do
        member do
          delete :delete_photo
        end
      end
      resources :events, only: %i[index new create edit update destroy]
    end
    # ユーザー管理
    get 'users', to: 'users/dashboard#index', as: :users_dashboard
    namespace :users do
      get 'monitor_posts', to: 'monitor_posts#index', as: :monitor_posts
      get 'analytics', to: 'analytics#index', as: :analytics
    end

    resources :users, only: %i[index edit update destroy]
  end
end
