class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update ]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update]

  def index
    # @users = User.all.order(created_at: :desc)
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
    set_avatar
    if @user.save
      @user.send_activation_email
      flash[:notice] = "アカウント認証メールを送信しました。メールが届きましたら、24時間以内に本文記載の有効化リンクをクリックしてアカウントを認証してください。"
      redirect_to root_url
    else
      render "new", status: :unprocessable_entity
    end
  end

  def update
    set_avatar if @user.avatar.blank?
    if params[:user][:image_id]
      @user.avatar.purge
    end
    if @user.update(user_params)
      flash[:notice] = "プロフィールが変更されました"
      redirect_to @user
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
  end


  private

    def set_user
      @user = User.find_by(account_name: params[:account_name])
    end

    def user_params
      params.require(:user).permit(:account_type, :name, :gender, :avatar, :email, :content, :password, :password_confirmation)
    end

    def set_avatar
      @user.avatar.attach(params[:user][:avatar])
    end

    def require_same_user
      if current_user != @user
        flash[:alert] = "許可されていない操作です。プロフィールの編集、削除は作成者ご自身のみ可能です。"
        redirect_to @user
      end
    end


end
