# Preview all emails at http://localhost:5000/rails/mailers/notification
class NotificationPreview < ActionMailer::Preview
  def comment
    recipient = User.first
    sender = User.last
    comment = Comment.first

    NotificationMailer.comment(recipient, sender, comment)
  end

  def comment_reply
    recipient = User.first
    sender = User.last
    comment = Comment.first

    NotificationMailer.comment_reply(recipient, sender, comment)
  end

  def follow
    recipient = User.first
    sender = User.last
    comment = Comment.first

    NotificationMailer.follow(recipient, sender, comment)
  end

  def like
    recipient = User.first
    sender = User.last
    comment = Comment.first

    NotificationMailer.like(recipient, sender, comment)
  end
end
