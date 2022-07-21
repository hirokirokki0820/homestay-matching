class AccountActivationsController < ApplicationController
  # before_action :check_expiration, only: [:edit]

  def edit
    @user = User.find_by(email: params[:email])
    check_expiration
    if @user && !@user.activated? && @user.authenticated?(:activation, params[:id])
      @user.activate
      log_in @user
      flash[:notice] = "アカウントが有効化されました"
      redirect_to @user
    else
      flash[:error] = "このリンクは無効です"
      redirect_to root_url
    end
  end

  private
      # トークンが期限切れかどうか確認する
      def check_expiration
        if @user.activation_expired?
          flash[:error] = "リンクの有効期限を過ぎているため、認証できません"
          redirect_to signup_url
        end
      end
end
