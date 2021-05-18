class Tweet < ApplicationRecord
  # 投稿でテキストが空のツイートは登録できなくする
  validates :text, presence: true
  # １つの投稿は１人のユーザーに所属する
  belongs_to :user # usersテーブルとのアソシエーション
  # アソシエーションでbelongs_toを指定した場合、相手のモデルのid（今回はuser_id）が「空ではないか」というバリデーションが、
  # デフォルトでかかっているので記述の必要なし。
  has_many :comments # commentsテーブルとのアソシエーション

end
