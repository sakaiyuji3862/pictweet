FactoryBot.define do
  factory :user do
    # Faker ランダムの値を生成するgem。
    nickname              {Faker::Name.initials(number: 2)} # 2文字のイニシャル
    email                 {Faker::Internet.free_email} # メールアドレス
    password              {Faker::Internet.password(min_length: 6)} # 6文字以下のパスワード
    password_confirmation {password} #パスワード確認
  end
end