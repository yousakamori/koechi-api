FactoryBot.define do
  factory :follow_relationship do
    follower_id { FactoryBot.create(:user).id }
    following_id { FactoryBot.create(:user).id }
  end
end
