# Preview all emails at http://localhost:5000/rails/mailers/notification
class NotificationPreview < ActionMailer::Preview
  def comment_reply
    recipient = User.first
    sender = User.last
    comment = Comment.first

    NotificationMailer.comment_reply(recipient, sender, comment)
  end
end
