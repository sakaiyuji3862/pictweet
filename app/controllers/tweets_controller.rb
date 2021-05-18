class TweetsController < ApplicationController
  # before_action :処理させたいメソッド名。only:で、どのアクションが実行される前に共通の処理をするか
  before_action :set_tweet, only: [:edit, :show]
  # 事前処理。index,show,search以外にmove_to_indexメソッド実行。 exceptは除外するという意味のオプション
  before_action :move_to_index, except: [:index, :show, :search]# →この３つは除外して実行したい
  # トップページ.一覧表示
  def index
    # モデル名.includes(:紐つくモデル名)。すべてのレコードを取得(N + 1問題解決)。allは省略可。
    # インスタンス = モデル名.order("並び替えの基準となるカラム名 並び順")
    @tweets = Tweet.includes(:user).order("created_at DESC")
  end
  # ツイート投稿ページ.生成
  def new
    # Tweetクラスの空のインスタンス変数を生成.保存用
    @tweet = Tweet.new
  end
  # 投稿が完了しましたページ.保存
  def create
    tweet = Tweet.find(params[:id])
    # newで送信した値を引数のtweet_paramsメソッドを呼び出し、処理を実行してデータベースに保存
    Tweet.create(tweet_params)
  end

  def destroy
    # findで特定のIDのレコードをテーブルから取得。削除したいtweet_path(tweet.id)が(params[:id])に入る
    tweet = Tweet.find(params[:id])
    # インスタンス名.メソッド名
    tweet.destroy
  end

  def edit

  end

  def update
    # 編集して送信されたparams[:id]の情報をtweetインスタンスへ代入
    tweet = Tweet.find(params[:id])
    # ストロングパラメーターでチェックして、インスタンス.メソッド名で更新
    tweet.update(tweet_params)
  end

  def show
    # Commentクラスの空のインスタンス変数を生成.保存用.
    @comment = Comment.new
    # アソシエーションが組まれている為、@tweet.commentsとすることで、@tweetへ投稿されたすべてのコメントを取得。includesでN + 1問題解決。
    @comments = @tweet.comments.includes(:user)
  end

  def search
    # index.htmlで送信した検索ワードがparams[:keyword]に入って、DBからとってくる。その値を@tweetsに代入。search.htmlへ。
    # app/services/SearchTweetsServiceに検索機能を記述している。
    @tweets = SearchTweetsService.search(params[:keyword])
  end

  private  # private以下の記述はすべてプライベートメソッドになる

  def tweet_params
    # require(:model)のpermitで指定した値(:image, :text)のみを取得(特定のキーを受け取る)。
    # current_userメソッドで現在ログインしているユーザーid(user_id)とtweetテーブル(:image, :text)をmergeメソッドで統合して紐つけて、
    # paramsに保存
    params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id)
  end

  def set_tweet
    # 変数@tweetの生成。params[:id]のレコードの情報を含む
    @tweet = Tweet.find(params[:id])
  end

  def move_to_index
    # user_signed_in? ログインしているかの判定。ログインしていなかったら実行
    unless user_signed_in?
      # index.htmlにリダイレクトする。 redirect_to action: :リダイレクト先となるアクション名
      redirect_to action: :index
    end
  end
end
