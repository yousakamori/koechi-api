json.id @current_user.id
json.name @current_user.name
json.username @current_user.username
json.bio @current_user.bio
json.twitter_username @current_user.twitter_username
json.avatar_url @current_user.avatar_url
json.following_user_ids @current_user.following_relationships.pluck(:following_id)
json.notifications_count @current_user.notifications_count
