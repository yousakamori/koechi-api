class UserMailer < ApplicationMailer
  def activation_needed_email(user, link, token_expiration_time)
    @user = user
    @link = link
    @token_expiration_time = token_expiration_time
    mail to: user.email, subject: 'メールアドレスのご確認'
  end

  def reset_password_email(user, link, token_expiration_time)
    @user = user
    @link = link
    @token_expiration_time = token_expiration_time
    mail to: user.email, subject: 'パスワードの再設定'
  end

  def reset_email(user, link, token_expiration_time)
    @user = user
    @link = link
    @token_expiration_time = token_expiration_time
    mail to: user.unconfirmed_email, subject: 'メールアドレスの再設定'
  end
end
