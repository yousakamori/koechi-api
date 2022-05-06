class NotificationMailer < ApplicationMailer
  def comment(recipient, sender, notifiable)
    @recipient = recipient
    @sender = sender
    @notifiable = notifiable
    @slug = @notifiable.commentable.slug
    @title = @notifiable.commentable.title.truncate(30)
    @type =  @notifiable.commentable_type.pluralize.underscore

    mail to: recipient.email, subject: 'コメントがつきました'
  end

  def comment_reply(recipient, sender, notifiable)
    @recipient = recipient
    @sender = sender
    @notifiable = notifiable

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
    @notifiable = notifiable
    @type = @notifiable.class.name.pluralize.underscore
    @title = @notifiable.try(:title).try(:truncate, 30) || 'あなたのコメント'
    
    mail to: recipient.email, subject: "#{@title}がいいねされました"
  end
end
