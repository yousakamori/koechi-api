class Comment < ApplicationRecord
  include Rails.application.routes.url_helpers
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
  counter_culture :commentable, column_name: 'comments_count', touch: 'last_comment_created_at'
  # ___________________________________________________________________________
  #
  validates :body_json, presence: true
  validates :commentable_type, presence: true, inclusion: { in: %w[Talk Note] }
  # ___________________________________________________________________________
  #
  before_create SetSlug.new
  before_update { |comment| comment.body_updated_at = Time.current }
  # ___________________________________________________________________________
  #
  def reply
    !!parent_id
  end
end
