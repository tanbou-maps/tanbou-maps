Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # 新しくsign_upという、ルーティングを作成
  resources :vue, only: %i[index create show] do
    collection do
      get 'sign_up'
    end
  end
end
