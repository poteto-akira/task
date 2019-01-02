class ApplicationController < ActionController::Base
  include SessionHelper

  private

  # ユーザーのログインを確認する
  def logged_in_user
    unless logged_in?
      store_location
      redirect_to login_url, notice: "ログインしてください"
    end
  end

end
