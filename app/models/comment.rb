class Comment < ApplicationRecord
  include Rails.application.routes.url_helpers
  include CurrentUserConditions
  # ___________________________________________________________________________
  #
  has_many :likes, -> { where liked: true }, as: :likable, dependent: :destroy
  has_many :children, -> { order 'created_at ASC' }, class_name: 'Comment', foreign_key: 'parent_id', dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  belongs_to :parent, class_name: 'Comment', optional: true
  # ___________________________________________________________________________
  #
  counter_culture :commentable, column_name: 'comments_count'
  # ___________________________________________________________________________
  #
  validates :body_json, presence: true
  # ___________________________________________________________________________
  #
  after_save :update_last_comment_created_at!
  after_destroy :update_last_comment_created_at!
  before_create SetSlug.new
  before_update { |comment| comment.body_updated_at = Time.current }
  # ___________________________________________________________________________
  #
  def reply
    !!parent_id
  end

  def update_last_comment_created_at!
    if commentable_type == 'Talk' || commentable_type == 'Note'
      # talkの最終更新時間を更新
      commentable.update!(last_comment_created_at: commentable.comments_count > 0 ? updated_at : nil)
    end
  end
end
