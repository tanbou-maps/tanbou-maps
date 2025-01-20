Rails.application.routes.draw do
  root 'index#show'

  # サインアップ・サインイン関連
  get 'signin', to: 'sessions#new'
  post 'signin', to: 'sessions#create'
  get 'signup', to: 'registration#new'
  post 'signup', to: 'registration#create'
  get 'signout', to: 'sessions#signout'
  delete 'signout', to: 'sessions#destroy_session'

  # ユーザープロフィール
  resources :user_profile, only: %i[new create show] do
    # URLにidが指定されない場合のルーティング
    collection do
      post :upload
      post :upload_profile_picture
      post :update_text
      patch :update_nickname
      delete :destroy_account
    end
    # URLにidが指定された場合のルーティング
    member do
      post :upload
      post :upload_profile_picture
      post :update_text
      patch :update_nickname
      delete :destroy_account
    end
  end

  # urlでidを指定して表示するユーザープロフィール
  get 'user-profile-view/:id', to: 'user_profile#view'
  get 'user-profile-crud/:id', to: 'user_profile#show'

  # urlでidを指定せずに表示するユーザープロフィール
  get 'user-profile-crud', to: 'user_profile#new'
  get 'user-profile-view', to: 'user_profile#view'

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

  # get 'user-prifile-crud', to: 'user_profile#upload'
  # サインアップ完了後の挙動
  get 'registration/registration-success', to: 'registration#complete', as: 'complete_registration'
  # サインアウト後の挙動
  get 'sessions/signout', to: 'sessions#signout', as: 'signout_sessions'

  resources :components, only: %i[index SignIn SignUp]

  # スポット CRUD
  resources :spots, only: %i[new create index show] do
    resources :reviews, only: %i[index new create show] # showアクションを追加
    collection do
      get 'search'
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

  # お問い合わせ-利用規約
  get '/contacts/terms', to: 'contacts#terms'
end
