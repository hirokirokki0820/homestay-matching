class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "【Home Matching】アカウントを有効化してください"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "【Home Matching】パスワードの再設定を行ってください"
  end
end
