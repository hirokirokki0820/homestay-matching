class ApplicationController < ActionController::Base

  helper_method :log_in, :current_user, :logged_in?, :log_out

  # ログイン時にセッションIDを付与する
  def log_in(user)
    session[:user_id] = user.id
  end

  # ユーザーのセッションをcookieに保存する（永続的セッション）
  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # 現在ログインしているユーザーのユーザー情報を取得する
  def current_user
    if(user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif(user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in(user)
        @current_user = user
      end
    end
  end

  # ユーザーがログインしているかどうかをチェックする
  def logged_in?
    !current_user.nil?
  end

  def require_user
    if !logged_in?
      flash[:alert] = "ログインしてください。"
      redirect_to login_path
    end
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # ログアウトする（セッション情報を削除する）
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

end
