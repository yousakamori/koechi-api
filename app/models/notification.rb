class Notification < ApplicationRecord
  belongs_to :notifiable, polymorphic: true, optional: true
  belongs_to :sender, class_name: 'User', optional: true
  belongs_to :recipient, class_name: 'User'
  # ___________________________________________________________________________
  #
  counter_culture :recipient, column_name: proc { |model| !model.checked? ? 'notifications_count' : nil }
  # ___________________________________________________________________________
  #
  validates :action, presence: true, inclusion: { in: %w[follow comment comment_reply like note invite] }
  validates :notifiable_type, inclusion: { in: %w[Comment Note Membership Talk] }, allow_nil: true
  # ___________________________________________________________________________
  #
  scope :recent, -> { order(updated_at: :desc) }
  # ___________________________________________________________________________
  #
  def action_text
    {
      'follow' => 'をフォローしました',
      'comment' => 'にコメントしました',
      'comment_reply' => 'に返信しました',
      'like' => 'にいいねをつけました',
      'note' => 'を投稿しました',
      'invite' => 'に招待しました'
    }[action]
  end

  def notifiable_slug
    case action
    when 'follow'
      nil
    when 'invite'
      notifiable.space.slug
    else
      notifiable.slug
    end
  end

  def notifiable_title
    case action
    when 'note'
      notifiable.title
    when 'comment'
      notifiable.commentable.title
    when 'comment_reply'
      'あなたのコメント'
    when 'like'
      notifiable.try(:title) || 'あなたのコメント'
    when 'invite'
      notifiable.space.name
    end
  end

  class << self
    def to_recipient!(action:, recipient:, sender: nil, notifiable: nil)
      return if recipient == sender

      @action = action
      @recipient = recipient
      @sender = sender
      @notifiable = notifiable

      notification = recipient.notifications.where(action: action, sender_id: sender.id, notifiable: notifiable).first_or_create! do |n|
        n.checked = false
      end

      # TODO: batch処理にしたい(whenever?)
      send_email! unless notification.checked
    end

    private

    # TODO: batch処理にしたい(whenever?)
    def send_email!
      return unless %i[follow comment comment_reply like].include?(@action)
      return if %i[comment comment_reply].include?(@action) && !@recipient.email_notify_comments
      return if @action == :like && !@recipient.email_notify_likes
      return if @action == :follow && !@recipient.email_notify_followings

      NotificationMailer.public_send(@action, @recipient, @sender, @notifiable).deliver_later
    end
  end
end
