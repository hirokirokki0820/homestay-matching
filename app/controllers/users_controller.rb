class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update ]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update]

  def index
    @users = User.all.order(created_at: :desc)
  end

  def show
    # @user = User.find_by(id: session[:user_id])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:notice] = "アカウント認証メールを送信しました。メールが届きましたら、24時間以内に本文記載の有効化リンクをクリックしてアカウントを認証してください。"
      redirect_to root_url
    else
      render "new", status: :unprocessable_entity
    end
  end

  def update
    # if params[:user][:password].blank?
    #   @user.errors.add(:password, :blank)
    #   render "edit", status: :unprocessable_entity
    # elsif @user.update(user_params)
    #   flash[:notice] = "パスワードが変更されました"
    #   redirect_to @user
    # else
    #   render "edit", status: :unprocessable_entity
    # end
  end

  def destroy
  end


  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :gender, :email, :password, :password_confirmation)
    end

    def require_same_user
      if current_user != @user
        flash[:alert] = "許可されていない操作です。プロフィールの編集、削除は作成者ご自身のみ可能です。"
        redirect_to @user
      end
    end


end
