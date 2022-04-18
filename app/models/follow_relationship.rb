class FollowRelationship < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :following, class_name: 'User'
  # ___________________________________________________________________________
  #
  validates :follower_id, presence: true
  validates :following_id, presence: true
  validates :follower_id, uniqueness: { scope: :following_id }
  # ___________________________________________________________________________
  #
  counter_culture :follower, column_name: 'following_count'
  counter_culture :following, column_name: 'follower_count'
end
