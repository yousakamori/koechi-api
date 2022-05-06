json.extract! @current_user, :id, :name, :username, :bio, :twitter_username, :avatar_url, :notifications_count,
              :email_notify_comments, :email_notify_likes, :email_notify_followings
json.following_user_ids @current_user.following_relationships.pluck(:following_id)
