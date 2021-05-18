Rails.application.routes.draw do
  # devise_forは、ユーザー機能に必要な複数のルーティングを一度に生成してくれるdeviseのメソッド
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # Railsの「初期画面」が表示されずに、トップページへ行くように
  root to: 'tweets#index'
  # resourcesは7つのアクションへのルーティングを自動生成してくれる
  resources :tweets do # ルーティングのネスト。親子関係にする(ある投稿に対してのコメントする機能を作る為)
    resources :comments, only: :create # 「コメントを作る機能」を実装するのでcreateアクションのルーティングを記述
    # 今回の検索機能の場合、詳細ページのような:idを指定して特定のページにいく必要がないため、collectionを使用してルーティングを設定
    collection do # collectionはルーティングに:idがつかない、memberは:idがつくという違い
      get 'search'
    end
  end
  # ユーザーのshowアクションのルーティング
  resources :users, only: :show
end



