class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: session_params[:email].downcase)
    if @user && @user.authenticate(session_params[:password])
      log_in(@user)
      flash[:notice] = "こんにちは、#{@user.name}さん"
      redirect_to @user
    else
      @user = User.new(session_params)
      flash.now[:error] = "ログインに失敗しました"
      render "new", status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to root_path, status: :see_other
  end

  private
    def session_params
      params.require(:session).permit(:email, :password)
    end

end
