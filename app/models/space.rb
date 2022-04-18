class Space < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :notes, dependent: :destroy
  belongs_to :owner, class_name: 'User'
  # ___________________________________________________________________________
  #
  validates :name, presence: true, length: { maximum: 70, allow_blank: true }
  validates :emoji, presence: true, length: { maximum: 50, allow_blank: true }
  # ___________________________________________________________________________
  #
  before_create SetSlug.new
  before_update :update_archived_at
  before_validation :format_emoji
  # ___________________________________________________________________________
  #
  def member?(user)
    users.include?(user)
  end

  def owner?(user)
    owner == user
  end

  private

  def update_archived_at
    self.archived_at = Time.current if will_save_change_to_archived?
  end

  def format_emoji
    self.emoji = emoji.scan(EmojiRegex::Regex).first
  end
end
