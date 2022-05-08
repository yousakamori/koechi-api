json.user do
  json.extract! @user, :id, :name, :username, :bio, :autolinked_bio,
                :twitter_username, :avatar_small_url, :avatar_url, :following_count, :follower_count

  json.is_mine @user == @current_user
  json.following_user_ids @user.following_relationships.pluck(:following_id)
  json.total_liked_count 0
  json.talks_count @user.talks.count
end
