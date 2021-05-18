class SearchTweetsService
  def self.search(search) #クラスメソッド
    # 検索フォームに何か値が入力されていた場合に実行
    if search != ""
      # モデル.where('検索対象となるカラムを含む条件式')。テーブル内の(条件に一致したレコードのインスタンス)を配列の形で取得。
      Tweet.where('text LIKE(?)', "%#{search}%") # 記述した文字が含まれるtext
    else # 値が空だったら、すべての投稿を取得して表示
      Tweet.all
    end # 検索など、テーブルとのやりとりに関するメソッドはモデルに記述する。
  end
end
