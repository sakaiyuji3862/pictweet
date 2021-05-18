class CommentsController < ApplicationController
  def create
    # コメントの値はcomment_paramsメソッドのストロングパラメーターで審査してcreateで保存。commentに代入。
    comment = Comment.create(comment_params) # tweets/show.html.erbのフォームを送信された値。
    # コメントと結びつくツイートの詳細画面に遷移する
    redirect_to "/tweets/#{comment.tweet.id}"
  end

  private
  def comment_params
    # require(:model)のpermitで指定した値(:text)のみを取得(特定のキーを受け取る)。
    # user_idカラムには、ログインしているユーザーidとなるcurrent_user.idを保存し、tweet.idカラムはparamsで渡されるように。
    # mergeメソッドで統合して紐つけて、paramsに保存
    params.require(:comment).permit(:text).merge(user_id: current_user.id, tweet_id: params[:tweet_id])
  end
end
