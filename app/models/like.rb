class Like < ApplicationRecord
  has_many :notifications, as: :notifiable, dependent: :destroy
  belongs_to :user
  belongs_to :likable, polymorphic: true
  belongs_to :note, -> {
                      joins(:likes).where(likes: { id: Like.where(likable_type: 'Note') })
                    }, foreign_key: :likable_id, optional: true
  # ___________________________________________________________________________
  #
  validates :likable_type, presence: true, inclusion: { in: %w[Comment Talk Note] }
  # ___________________________________________________________________________
  #
  scope :liked, -> { where(liked: true) }
  # ___________________________________________________________________________
  #
  counter_culture :likable, column_name: proc { |model| model.liked? ? 'liked_count' : nil }
  # ___________________________________________________________________________
  #
  def title
    case likable_type
    when 'Note', 'Talk'
      likable.title
    when 'Comment'
      likable.body_text.truncate(140)
    end
  end

  def posted_at
    case likable_type
    when 'Note'
      likable.posted_at
    when 'Comment', 'Talk'
      likable.created_at
    end
  end

  def post_type
    likable_type
  end

  def shortlink_path
    type = likable_type.pluralize.downcase
    slug = likable.slug
    "/link/#{type}/#{slug}"
  end
end
