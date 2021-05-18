class UsersController < ApplicationController
  def show
    # マイページをクリックして、送られたidをparamsで取得し、そのユーザーのレコードを変数userに代入
    user = User.find(params[:id])
    @nickname = user.nickname # users/show.html.erbへ(マイページ)
    # アソシエーションを利用しuser.tweetsとすることで、そのユーザーが投稿したツイートを取得して、@tweetsに代入する
    @tweets = user.tweets # users/show.html.erbへ(マイページ)
  end
end
# @nicknameはcurrent_userを利用し、現在ログインしているユーザーが持つnicknameカラムの値を取得 → マイページへ。
# @tweetsは現在ログインしているユーザーのツイート投稿を取得 → マイページへ。