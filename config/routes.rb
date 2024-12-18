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
  get 'registration/registration-success', to: 'registration#complete', as: 'complete_registration'
  # サインアウト後の挙動
  get 'sessions/signout', to: 'sessions#signout', as: 'signout_sessions'
  # レビューテスト用ルーティング
  get "/review-test", to: "review_test#index", as: "review_test_index"
  get "/review-test/new", to: "review_test#new", as: "review_test_new"
  post "/review-test", to: "review_test#create"
  get "/review-test/:id", to: "review_test#show", as: "review_test_details"
  delete '/review-test/:id', to: 'review_test#destroy', as: "review_test_delete"
  get "/review-test/:id/edit", to: "review_test#edit", as: "edit_review_test"
  patch "/review-test/:id", to: "review_test#update", as: "review_test_update"
  # レビュー関連ルーティング
  get "review", to: "review#index"
  get "review/new", to: "review#new", as: "new_review"
  post "review", to: "review#create", as: "new_spot_review"

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

  resources :spots do
    resources :reviews, shallow: true
  end

  resources :spots do
    resources :reviews do
      collection do
        get 'complete' # レビュー投稿完了ページ
      end
    end
  end
end
