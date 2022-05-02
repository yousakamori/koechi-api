require 'rails_helper'

RSpec.describe FollowRelationship, type: :model do
  it 'follower_idとfollowing_idでユニークであること' do
    follower = create(:user)
    following = create(:user)

    create(:follow_relationship, follower_id: follower.id, following_id: following.id)
    follow = build(:follow_relationship, follower_id: follower.id, following_id: following.id)
    follow.valid?

    expect(follow.errors[:follower_id]).to include('はすでに存在します')
  end
end
