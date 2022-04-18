json.talk do
  json.extract! @talk, :id, :title, :slug, :user_id, :created_at, :archived, :closed, :closed_at, :last_comment_created_at,
                :comments_count, :liked_count
  json.is_mine @talk.mine?(@current_user)
  json.current_user_liked @talk.current_user_liked?(@current_user)

  json.user do
    json.extract! @user, :id, :name, :username, :avatar_small_url, :avatar_url, :twitter_username, :autolinked_bio
  end
end

json.comments do
  json.array! @comments do |comment|
    json.extract! comment, :id, :body_text, :body_json, :created_at, :user_id, :parent_id, :body_updated_at, :slug,
                  :liked_count
    json.is_mine comment.mine?(@current_user)
    json.current_user_liked comment.current_user_liked?(@current_user)

    json.user do
      json.extract! comment.user, :id, :name, :username, :avatar_small_url
    end

    json.children do
      json.array! comment.children do |child|
        json.extract! child, :id, :body_text, :body_json, :created_at, :user_id, :parent_id, :body_updated_at, :slug,
                      :liked_count
        json.is_mine child.mine?(@current_user)
        json.current_user_liked child.current_user_liked?(@current_user)

        json.user do
          json.extract! child.user, :id, :name, :username, :avatar_small_url
        end
      end
    end
  end
end

json.participants do
  json.array! @participants do |participant|
    json.extract! participant, :id, :name, :username, :avatar_small_url
  end
end
