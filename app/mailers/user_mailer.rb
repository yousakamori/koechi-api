class UserMailer < ApplicationMailer
  def confirmation_email(user, magic_link, token_expiration_time)
    @user = user
    @magic_link = magic_link
    @token_expiration_time = token_expiration_time
    mail to: user.email, subject: 'メールアドレスの確認'
  end

  def reset_password(user, magic_link, token_expiration_time)
    @user = user
    @magic_link = magic_link
    @token_expiration_time = token_expiration_time
    mail to: user.email, subject: 'パスワードの再設定'
  end

  def reset_email(user, magic_link, token_expiration_time)
    @user = user
    @magic_link = magic_link
    @token_expiration_time = token_expiration_time
    mail to: user.unconfirmed_email, subject: 'メールアドレスの再設定'
  end
end
