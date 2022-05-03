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

      notification = recipient.notifications.find_or_initialize_by!(action: action, sender_id: sender.id, notifiable: notifiable)
      notification.checked = false
      notification.save!

      send_email!
    end

    private

    def send_email!
      # return unless %w[follow comment comment_reply like invite].include?(@action)
      return unless %w[follow comment_reply like invite].include?(@action)

      NotificationMailer.public_send(@action.to_sym, @recipient, @sender, @notifiable).deliver_later
    end
  end
end
