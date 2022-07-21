class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "【Home Matching】アカウントを認証してください"
  end
end
