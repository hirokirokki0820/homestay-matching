class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: session_params[:email].downcase)
    if @user && @user.authenticate(session_params[:password])
      if @user.activated?
        log_in(@user)
        session_params[:remember_me] == "1" ? remember(@user) : forget(@user)
        flash[:notice] = "こんにちは、#{@user.name}さん"
        redirect_to @user
      else
        message = "アカウントが有効化されていません。"
        message += "届いたメールをご確認の上、アカウントの認証を行ってください。"
        flash[:error] = message
        redirect_to root_url
      end
    else
      @user = User.new(session_params)
      flash.now[:error] = "メールアドレスまたはパスワードに誤りがあります"
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path, status: :see_other
  end

  private
    def session_params
      params.require(:session).permit(:email, :password, :remember_me)
    end

end
