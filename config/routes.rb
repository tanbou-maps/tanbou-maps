Rails.application.routes.draw do
  root 'index#show'

  # サインアップ・サインイン関連
  get 'sign-in', to: 'sessions#new'
  post 'sign-in', to: 'sessions#create'
  get 'sign-up', to: 'registration#new'
  post 'sign-up', to: 'registration#create'
  get 'sign-up-complete', to: 'registration#complete'
  get 'sign-out', to: 'sessions#destroy'

  # spots
  resources :spots, only: %i[new create index show] do
    resources :reviews, only: %i[index new create show destroy]
    collection do
      get :search
    end
  end

  # model courses
  resources :model_courses, path: 'model-courses', param: :record_uuid do
    member do
      patch :update
      delete :destroy
      patch :regenerate_public_key # 公開キー再発行用ルート
    end
  end


  # contact
  resources :contacts, only: %i[new create] do
    collection do
      get 'complete'
    end
  end

  # お問い合わせ-利用規約
  get '/contacts/terms', to: 'contacts#terms'

  # admin
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
