class User < ApplicationRecord
  include Rails.application.routes.url_helpers
  extend OrderAsSpecified

  has_secure_password
  has_one_attached :avatar do |attachable|
    attachable.variant :small, { resize: '80x80' }
  end
  # ___________________________________________________________________________
  #
  has_many :notes, dependent: :delete_all
  has_many :talks, dependent: :delete_all
  has_many :comments, dependent: :delete_all
  has_many :likes, dependent: :delete_all
  has_many :notifications, foreign_key: :recipient_id, dependent: :delete_all
  has_many :sender_notifications, class_name: 'Notification', foreign_key: :sender_id, dependent: :delete_all

  has_many :following_relationships, class_name: 'FollowRelationship', foreign_key: :follower_id,
                                     dependent: :delete_all
  has_many :followings, through: :following_relationships
  has_many :follower_relationships, class_name: 'FollowRelationship', foreign_key: :following_id, dependent: :delete_all
  has_many :followers, through: :follower_relationships

  has_many :memberships, dependent: :delete_all
  has_many :spaces, through: :memberships
  # ___________________________________________________________________________
  #
  attr_accessor :token_expiration_time, :magic_link

  scope :activated, -> { where.not(activated_at: nil) }
  scope :autocomplete, ->(name) {
                         where('username ILIKE ?', "#{name}%").or(where('name ILIKE ?', "#{name}%")).activated.order(:name).limit(50)
                       }
  enum role: { member: 0, admin: 10 }
  # ___________________________________________________________________________
  #
  before_validation :downcase_email
  before_update :activate
  before_update :remove_atmark_twitter_username
  # ___________________________________________________________________________
  #
  validates :email,
            presence: true,
            uniqueness_activated_email: true,
            length: { maximum: 254, allow_blank: true },
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, allow_blank: true },
            if: -> {  new_record? || changes[:email] }

  validates :password,
            format: { with: /\A[\w!@#$%-_=]{8,32}\z/i, allow_blank: true, message: :invalid_password },
            if: -> { new_record? || changes[:password_digest] }

  validates :name,
            presence: true,
            length: { maximum: 40, allow_blank: true },
            if: -> { changes[:name] }

  validates :username,
            presence: true,
            length: { minimum: 2, maximum: 15, allow_blank: true },
            format: { with: /\A[a-z\d_]+\z/, allow_blank: true },
            uniqueness: { message: :taken_username },
            namespace: true,
            if: -> { changes[:username] }

  validates :bio,
            length: { maximum: 160, allow_blank: true },
            if: -> { changes[:bio] }

  validates :role, presence: true

  validates :avatar, attached: true, allow_blank: true,
                     content_type: ['image/png', 'image/jpeg', 'image/gif'], size: { less_than: 5.megabytes }
  # ___________________________________________________________________________
  #
  TOKEN_EXPIRATION_PERIOD = {
    confirmation_email: 60.minutes,
    reset_email: 60.minutes,
    reset_password: 60.minutes
  }.freeze

  MAGIC_LINKS = {
    confirmation_email: "#{Rails.configuration.x.app.client_url}/login_with_email",
    reset_email: "#{Rails.configuration.x.app.client_url}/update_email",
    reset_password: "#{Rails.configuration.x.app.client_url}/update_password"
  }.freeze

  def avatar_url
    cdn_image_url(avatar) if avatar.attached?
  end

  def avatar_small_url
    cdn_image_url(avatar.variant(:small).processed) if avatar.attached?
  end

  def follow!(user_id)
    following_relationships.create!(following_id: user_id)
  end

  def unfollow!(user_id)
    following_relationships.find_by!(following_id: user_id).destroy!
  end

  def activated?
    !username.nil?
  end

  def autolinked_bio
    Rinku.auto_link(bio, :all, 'target="_blank" rel="nofollow noopener noreferrer"')
  end

  def send_email!(action, password = nil)
    token_expiration_period = TOKEN_EXPIRATION_PERIOD[action]
    base_magic_link = MAGIC_LINKS[action]
    signed_id = signed_id(expires_in: token_expiration_period, purpose: action)
    magic_link = "#{base_magic_link}?token=#{signed_id}"
    magic_link << "&password=#{password}" if password

    token_expiration_time = "#{token_expiration_period.in_minutes.to_i}分"
    UserMailer.public_send(action, self, magic_link, token_expiration_time).deliver_later
  end

  def self.generate_signup_code(length = 20)
    rlength = (length * 3) / 4
    SecureRandom.urlsafe_base64(rlength).tr('lIO0', 'sxyz')
  end
  # ___________________________________________________________________________
  #

  private

  def activate
    return unless will_save_change_to_username?

    self.activated_at = Time.current
  end

  def remove_atmark_twitter_username
    self.twitter_username = twitter_username.gsub(/\W/, '') if will_save_change_to_twitter_username?
  end

  def downcase_email
    self.email = email&.downcase
  end
end
