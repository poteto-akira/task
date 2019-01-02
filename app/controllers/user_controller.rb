class UserController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  def new
    @user = User.new
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to("/", notice: "ユーザー登録が完了しました")
    else
      render("new")
    end

  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update_attributes(user_params)
      redirect_to("/", notice: "ユーザー情報を変更しました")
    else
      render"edit"
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to("/", notice: "ユーザーを削除しました")
  end

  private

    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find_by(id: params[:id])
      redirect_to("/") unless current_user?(@user) # session_helper
    end
end
