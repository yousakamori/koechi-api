class Talk < ApplicationRecord
  include Rails.application.routes.url_helpers
  include CurrentUserConditions
  # ___________________________________________________________________________
  #
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy
  has_many :likes, -> { where liked: true }, as: :likable, dependent: :destroy
  belongs_to :user
  # ___________________________________________________________________________
  #
  before_create SetSlug.new
  before_update :close_talk
  # ___________________________________________________________________________
  #
  validates :title,
            presence: true,
            length: { maximum: 100, allow_blank: true }
  # ___________________________________________________________________________
  #
  weekly_conditions = <<-SQL
    LEFT JOIN likes
    ON  likes.likable_type = 'Talk'
    AND likes.liked = true
    AND likes.likable_id = talks.id
    AND likes.created_at >= '#{Time.current.weeks_ago(1)}'
  SQL

  scope :weekly, -> { joins(weekly_conditions).group('talks.id').order('count(likes.id) DESC, comments_count DESC') }
  scope :latest, -> { order('last_comment_created_at DESC NULLS LAST, closed_at DESC NULLS LAST, created_at DESC') }
  scope :alltime, -> { order(liked_count: :desc, comments_count: :desc) }
  scope :username, ->(username) { joins(:user).where(users: { username: username }) }
  scope :active, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }
  # ___________________________________________________________________________
  #

  private

  def close_talk
    return unless will_save_change_to_closed?

    self.closed_at = (closed? ? Time.current : nil)
  end
end
