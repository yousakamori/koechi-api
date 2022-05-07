class NotificationMailer < ApplicationMailer
  def comment(recipient, sender, notifiable)
    @recipient = recipient
    @sender = sender
    @title = notifiable.commentable.title.truncate(30)
    @notifiable_link = "#{Rails.configuration.x.app.client_url}/link/#{notifiable.commentable_type.pluralize.underscore}/#{notifiable.commentable.slug}"
    mail to: recipient.email, subject: 'コメントがつきました'
  end

  def comment_reply(recipient, sender, notifiable)
    @recipient = recipient
    @sender = sender
    @notifiable_link = "#{Rails.configuration.x.app.client_url}/link/comments/#{notifiable.slug}"
    mail to: recipient.email, subject: 'コメントに返信がつきました'
  end

  def follow(recipient, sender, notifiable)
    @recipient = recipient
    @sender = sender
    @notifiable = notifiable
    mail to: recipient.email, subject: "#{@recipient.name}さんにフォローされました"
  end

  def like(recipient, sender, notifiable)
    @recipient = recipient
    @sender = sender
    @title = notifiable.try(:title).try(:truncate, 30) || 'あなたのコメント'
    @liked_link = "#{Rails.configuration.x.app.client_url}/link/#{notifiable.class.name.pluralize.underscore}/#{notifiable.slug}"
    mail to: recipient.email, subject: "#{@title}がいいねされました"
  end
end
