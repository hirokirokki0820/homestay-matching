class AccountController < ApplicationController
  before_action :set_user
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user

  def edit
  end

  def update
    if params[:account][:password].blank?
      @user.errors.add(:password, :blank)
      render "edit", status: :unprocessable_entity
    elsif @user.update(user_params)
      flash[:notice] = "パスワードが変更されました"
      redirect_to @user
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = "アカウントを削除しました"
    redirect_to root_path, status: :see_other
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:account).permit(:password, :password_confirmation)
    end

    def require_same_user
      if current_user != @user
        flash[:alert] = "許可されていない操作です。プロフィールの編集、削除は作成者ご自身のみ可能です。"
        redirect_to @user
      end
    end

end
