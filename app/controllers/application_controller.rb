class ApplicationController < ActionController::Base
  # アプリケーション全体に対して基本認証を適用するためのフィルタ
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # ストロングパラメーターの設定
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :nickname, 
      :last_name, 
      :first_name, 
      :last_name_kana, 
      :first_name_kana, 
      :birth_date
    ])
  end

  private

  # 基本認証の設定
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end