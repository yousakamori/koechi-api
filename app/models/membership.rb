class Membership < ApplicationRecord
  extend OrderAsSpecified
  # ___________________________________________________________________________
  #
  belongs_to :user
  belongs_to :space
  has_many :notifications, as: :notifiable, dependent: :destroy
  # ___________________________________________________________________________
  #
  validates :user_id, presence: true
  validates :space_id, presence: true
  validates :user_id, uniqueness: { scope: :space_id }
  validates :role, presence: true
  # ___________________________________________________________________________
  #
  enum role: { member: 0, admin: 10 }
end
