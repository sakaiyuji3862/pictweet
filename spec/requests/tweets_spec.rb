require 'rails_helper'

RSpec.describe "Tweets", type: :request do
  
  before do
    @tweet = FactoryBot.create(:tweet)
  end

  describe "GET #index" do
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do 
      # get 〇〇_pathのように、どこのパスにリクエストを送りたいか。rails routesで確認。
      get root_path
      # expect(X).to eq Y。『XはYになる』という確認。eqはイコール(マッチャ)。
      # response リクエストに対するレスポンスそのものが含まれる。
      # response.statusと実行することで、そのレスポンスのステータスコードを出力できる
      expect(response.status).to eq 200
    end
    it "indexアクションにリクエストするとレスポンスに投稿済みのツイートのテキストが存在する" do 
      get root_path
      # response.bodyで、ブラウザに表示されるHTMLの情報を抜き出すことができる。
      # include。(含む)という意味。(Xの中にYという文字列が含まれているかどうか)を確認することができるマッチャ。
      # response.bodyに@tweet.textが含まれているか。
      expect(response.body).to include @tweet.text
    end
    it "indexアクションにリクエストするとレスポンスに投稿済みのツイートの画像URLが存在する" do 
      get root_path
      expect(response.body).to include @tweet.image
    end
    it "indexアクションにリクエストするとレスポンスに投稿検索フォームが存在する" do
      get root_path
      expect(response.body).to include "投稿を検索する"
    end
  end

  
  describe "GET #show" do
    it "showアクションにリクエストすると正常にレスポンスが返ってくる" do 
      get tweet_path(@tweet)
      expect(response.status).to eq 200
    end
    it "showアクションにリクエストするとレスポンスに投稿済みのツイートのテキストが存在する" do 
      get tweet_path(@tweet)
      expect(response.body).to include @tweet.text
    end
    it "showアクションにリクエストするとレスポンスに投稿済みのツイートの画像URLが存在する" do 
      get tweet_path(@tweet)
      expect(response.body).to include @tweet.image
    end
    it "showアクションにリクエストするとレスポンスにコメント一覧表示部分が存在する" do 
      get tweet_path(@tweet)
      expect(response.body).to include "＜コメント一覧＞"
    end
  end 
end
