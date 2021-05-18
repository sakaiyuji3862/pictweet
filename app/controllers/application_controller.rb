class ApplicationController < ActionController::Base
  # before_actionで事前処理。devise_controller?(deviseのヘルパーメソッド)
  # もしdeviseに関するコントローラーの処理であれば、configure_permitted_parametersを呼び出す
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  # configure_permitted_parametersは慣習的に使われる。
  # devise_parameter_sanitizerhaはdeviseのUserモデルに関わる(ログイン、新規投稿)などのリクエストからパラメーターを取得できる
  def configure_permitted_parameters
    # deviseのUserモデルにパラメーターを許可。permit(:deviseの処理名, keys: [:許可するキー])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    # deviseの処理を行うコントローラーはGem内に記述されているため、編集することができない。なので、後から追加した新規登録の
    # nicknameカラムのストロングパラメーターはコントローラーの親玉であるApplication_Controllerに記述する。
  end
end
