class Note < ApplicationRecord
  paginates_per 50 # TODO: default:25を変更 => ここで定義どうしよ?

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, -> { where liked: true }, as: :likable, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy
  belongs_to :user
  belongs_to :space
  # ___________________________________________________________________________
  #
  counter_culture :space, column_name: proc { |model| model.body_json ? 'notes_count' : nil }
  # ___________________________________________________________________________
  #
  validates :title, presence: true, on: :update, length: { maximum: 100, allow_blank: true }
  validates :body_text, length: { maximum: 40_000, allow_blank: true }
  # ___________________________________________________________________________
  #
  scope :active, -> { where.not(title: nil) }

  before_create SetSlug.new
  before_update do
    self.body_updated_at = Time.current if !body_json_in_database.nil? && will_save_change_to_body_json?
  end
  # ___________________________________________________________________________
  #
  def body_length
    body_text&.length || 0
  end

  def mine?(current_user)
    return false unless current_user

    user_id == current_user.id
  end
end
