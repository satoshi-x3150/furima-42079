class ApplicationController < ActionController::Base
  # アプリケーション全体に対して基本認証を適用するためのフィルタ
  before_action :basic_auth


  private

  # 基本認証の設定
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == 'admin' && password == '2222'
    end
  end
end