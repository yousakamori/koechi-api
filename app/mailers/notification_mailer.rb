class NotificationMailer < ApplicationMailer
  def comment_reply(recipient, sender, notifiable)
    return unless sender.email_notify_comments

    @recipient = recipient
    @sender = sender
    @notifiable = notifiable
    mail to: recipient.email, subject: 'コメントに返信がつきました'
  end

  # def comment(recipient)
  #   @recipient = recipient
  #   mail to: recipient.email, subject: 'コメント通知'
  # end

  # def follow(user)
  #   @user = user
  #   mail to: user.email, subject: 'メールアドレスのご確認'
  # end

  # def like(user)
  #   @user = user
  #   mail to: user.unconfirmed_email, subject: 'メールアドレスの再設定'
  # end
end
