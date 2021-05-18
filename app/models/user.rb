class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # １人のユーザー複数の投稿を所有する
  has_many :tweets # tweetsテーブルとのアソシエーション
  has_many :comments # commentsテーブルとのアソシエーション
# ログインで、ニックネームは空で登録できない かつ 最大で６文字
  validates :nickname, presence: true, length: {maximum: 6}
end
