json.comment do
  json.extract! @comment, :id, :body_text, :body_json, :created_at, :user_id, :parent_id, :body_updated_at, :slug,
                :liked_count, :reply
  json.current_user_liked false
  json.is_mine true
  json.children @comment.parent_id ? nil : []

  json.user do
    json.extract! @comment.user, :id, :name, :username, :avatar_small_url
  end
end
