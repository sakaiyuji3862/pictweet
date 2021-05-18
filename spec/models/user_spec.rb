require 'rails_helper'
describe User do
  before do
    @user = FactoryBot.build(:user) # Userのインスタンスを生成
  end
  # ディスクライブは、(〇〇について記述する)という意味。どのようなテストコードか説明。概要。
  describe 'ユーザー新規登録' do
    # contextは、どのような『状況』を確認したいのか。という意味。
    context '新規登録がうまくいくとき' do
      # イットは、(どのようなテストコードをかいているのか)説明。
      it "nicknameとemail、passwordとpassword_confirmationが存在すれば登録できる" do
        # expect(インスタンス).to be_valid。expectのインスタンスが正しく保存されることを判断する。
        # be_valid正常に完了することを判断するためのマッチャ。
        expect(@user).to be_valid
      end
      it "nicknameが6文字以下で登録できる" do
        @user.nickname = "aaaaaa"
        expect(@user).to be_valid
      end
      it "passwordが6文字以上であれば登録できる" do
        @user.password = "000000"
        @user.password_confirmation = "000000"
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it "nicknameが空だと登録できない" do
        @user.nickname = ''
        @user.valid?
      # errors。valid?にて判定されたデータのエラーを表示するメソッド。続けてfull_messagesメソッドを使用。
      # full_messages。生成されたエラーの中から、エラーメッセージを出力するためのメソッド。
      # include。(含む)という意味。(Xの中にYという文字列が含まれているかどうか)を確認することができるマッチャ。
        expect(@user.errors.full_messages).to include("Nickname can't be blank") # 空白にすることはできません
      end
      it "nicknameが7文字以上であれば登録できない" do
        @user.nickname = "aaaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname is too long (maximum is 6 characters)") # 長すぎます（最大6文字）
      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank") # 空白にすることはできません
      end
      it "重複したemailが存在する場合登録できない" do
        @user.save # 生成した@userをテーブルに保存
        another_user = FactoryBot.build(:user) # 再度別のユーザー(another_user)を生成する
        another_user.email = @user.email # another_userのemailを既に保存済みの@userのemailに上書きする
        another_user.valid? # another_userが保存されるかどうかを判別する
        expect(another_user.errors.full_messages).to include("Email has already been taken") # すでに使われています
      end
      it "passwordが空では登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank") # 空白にすることはできません
      end
      it "passwordが5文字以下であれば登録できない" do
        @user.password = "00000"
        @user.password_confirmation = "00000"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimun is 6 characters)") # 短すぎます（最小6文字）
      end
      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password") # パスワードの確認がパスワードと一致しません
      end
    end
  end
end
 




# # RailsにおいてRSpecを利用する際に、共通の設定をかいておくファイル
# require 'rails_helper'
# RSpec.describe User, type: :model do
#   # before  それぞれのテストコードを実行する前に、セットアップを行うことができる。同様の記述をまとめる。
#   # 変数を受け渡す際は、beforeに定義する変数はインスタンス変数にする必要がある。
#   before do
#     # FactoryBotはインスタンスをまとめるgem。他のファイルであらかじめ各クラスのインスタンスに定める値を設定。各テストコードで使用。
#     # build。newメソッドと同様の意味を持つ。
#     @user = FactoryBot.build(:user) # Userのインスタンスを生成
#   end

#   # ディスクライブは、(〇〇について記述する)という意味。どのようなテストコードか説明。概要。
#   describe 'ユーザー新規登録' do
#     # イットは、(どのようなテストコードをかいているのか)説明。
#     it "nicknameが空だと登録できない" do
#       @user.nickname = "" # nicknameの値を空にする
#       # バリッドは、(正しい)という意味。正しいかどうかを判定。保存されない場合はエラーメッセージも生成。
#       @user.valid?
#       # expect(X).to eq Y(Xの結果はYになる)。eq(イコール)を意味する。eqのように結果を判断するものをマッチャと呼ぶ。
#       # errors。valid?にて判定されたデータのエラーを表示するメソッド。続けてfull_messagesメソッドを使用。
#       # full_messages。生成されたエラーの中から、エラーメッセージを出力するためのメソッド。
#       # include。(含む)という意味。(Xの中にYという文字列が含まれているかどうか)を確認することができるマッチャ。
#       expect(@user.errors.full_messages).to include("Nickname can't be blank")
#     end
#     it "emailが空では登録できない" do
#       @user.email = "" # emailの値を空にする
#       @user.valid?
#       expect(@user.errors.full_messages).to include("Email can't be blank")
#     end
#   end
# end
