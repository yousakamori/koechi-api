class User < ApplicationRecord
  include Rails.application.routes.url_helpers
  extend OrderAsSpecified

  has_secure_password
  has_one_attached :avatar do |attachable|
    attachable.variant :small, resize: '80x80'
  end
  # ___________________________________________________________________________
  #
  has_many :notes, dependent: :delete_all
  has_many :talks, dependent: :delete_all
  has_many :comments, dependent: :delete_all
  has_many :likes, dependent: :delete_all
  has_many :notifications, foreign_key: :recipient_id, dependent: :delete_all
  has_many :sender_notifications, class_name: 'Notification', foreign_key: :sender_id, dependent: :delete_all

  has_many :following_relationships, class_name: 'FollowRelationship', foreign_key: :follower_id,  dependent: :delete_all
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

  validates :avatar, attached: true, allow_blank: true, content_type: ['image/png', 'image/jpeg', 'image/gif'],
                     size: { less_than: 5.megabytes }
  # ___________________________________________________________________________
  #
  def email_registration!
    self.password = User.generate_signup_code
    save!
    setup_activation_magic_link
    send_activation_needed_email
    self
  end

  def reset_password
    setup_reset_password_magic_link
    send_reset_password_email
    self
  end

  def reset_email
    setup_reset_email_magic_link
    send_reset_email
    self
  end

  def avatar_url
    cdn_image_url(avatar) if avatar.attached?
  end

  def avatar_small_url
    cdn_image_url(avatar.variant(:small).processed) if avatar.attached?
  end

  def self.generate_signup_code(length = 20)
    rlength = (length * 3) / 4
    SecureRandom.urlsafe_base64(rlength).tr('lIO0', 'sxyz')
  end

  def follow!(user_id)
    following_relationships.create!(following_id: user_id)
  end

  def unfollow!(user_id)
    following_relationships.find_by!(following_id: user_id).destroy!
  end

  def activated?
    !activated_at.nil?
  end

  def autolinked_bio
    Rinku.auto_link(bio, :all, 'target="_blank" rel="nofollow noopener noreferrer"')
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

  # TODO: メールの文章修正
  ACTIVATION_TOKEN_EXPIRATION_PERIOD = 60.minutes
  def setup_activation_magic_link
    signed_id = signed_id(expires_in: ACTIVATION_TOKEN_EXPIRATION_PERIOD, purpose: :email_activate)
    self.token_expiration_time = "#{ACTIVATION_TOKEN_EXPIRATION_PERIOD.in_minutes.to_i}分"
    self.magic_link = "#{Rails.configuration.x.app.client_url}/login_with_email?token=#{signed_id}&password=#{password}"
  end

  def send_activation_needed_email
    UserMailer.activation_needed_email(self).deliver_now
  end

  # TODO: メールの文章修正
  PASSWORD_TOKEN_EXPIRATION_PERIOD = 60.minutes
  def setup_reset_password_magic_link
    signed_id = signed_id(expires_in: PASSWORD_TOKEN_EXPIRATION_PERIOD, purpose: :reset_password)
    self.token_expiration_time = "#{PASSWORD_TOKEN_EXPIRATION_PERIOD.in_minutes.to_i}分"
    self.magic_link = "#{Rails.configuration.x.app.client_url}/update_password?token=#{signed_id}"
  end

  def send_reset_password_email
    UserMailer.reset_password_email(self).deliver_now
  end

  # TODO: メールの文章修正
  EMAIL_TOKEN_EXPIRATION_PERIOD = 60.minutes
  def setup_reset_email_magic_link
    signed_id = signed_id(expires_in: EMAIL_TOKEN_EXPIRATION_PERIOD, purpose: :reset_email)
    self.token_expiration_time = "#{EMAIL_TOKEN_EXPIRATION_PERIOD.in_minutes.to_i}分"
    self.magic_link = "#{Rails.configuration.x.app.client_url}/update_email?token=#{signed_id}"
  end

  def send_reset_email
    UserMailer.reset_email(self).deliver_now
  end
end
