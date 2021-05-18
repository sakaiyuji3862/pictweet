require 'rails_helper'

RSpec.describe Tweet, type: :model do
  before do
    @tweet = FactoryBot.build(:tweet)
  end
  # ディスクライブは、(〇〇について記述する)という意味。どのようなテストコードか説明。概要。
  describe 'ツイートの保存' do
    # contextは、どのような『状況』を確認したいのか。という意味。
    context "ツイートが保存できる場合" do
      it "画像とテキストがあればツイートは保存される" do
        # expect(インスタンス).to be_valid。expectのインスタンスが正しく保存されることを判断する。
        # be_valid正常に完了することを判断するためのマッチャ。
        expect(@tweet).to be_valid
      end
      it "テキストのみあればツイートは保存される" do
        @tweet.image = ""
        expect(@tweet).to be_valid
      end
    end
    context "ツイートが保存できない場合" do
      it "テキストがないとツイートは保存できない" do
        @tweet.text = ""
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("Text can't be blank") # 空白にすることはできません
      end     
      it "ユーザーが紐付いていないとツイートは保存できない" do
        @tweet.user = nil # nil == 無いもの
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("User must exist") # ユーザーが存在する必要があります
      end
    end
  end
end
