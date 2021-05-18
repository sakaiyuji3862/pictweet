FactoryBot.define do
  factory :tweet do
    # Faker ランダムの値を生成するgem。Lorem ダミー。sentence 文。
    text {Faker::Lorem.sentence} # ダミーテキスト
    image {Faker::Lorem.sentence} # ダミーイメージ
    # user.rbの FactoryBotとアソシエーションがあることを意味する
    association :user
  end
end
# Tweetに対しては、必ずUserが紐ついてる必要があるため、このように記述する必要はない。
# (UserはTweetを必ず持っているわけではないので。user.rbには記述しない)
