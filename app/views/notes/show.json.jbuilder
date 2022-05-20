json.note do
  json.extract! @note, :id, :title, :body_text, :body_json, :slug, :body_updated_at, :posted_at,
                :last_comment_created_at, :liked_count, :comments_count, :updated_at, :created_at

  json.is_mine @note.mine?(@current_user)
  json.current_user_liked @note.current_user_liked?(@current_user)
  json.body_letters_count @note.body_length

  json.user do
    json.extract! @note.user, :id, :name, :username, :avatar_small_url
  end
end

json.space do
  json.extract! @space, :id, :name, :emoji, :slug
  json.role @space.memberships.find { |m| m.user_id == @current_user.id }.role
end

json.comments do
  json.array! @comments, partial: 'shared/comments', as: :comment
end

json.participants do
  json.array! @participants do |participant|
    json.extract! participant, :id, :name, :username, :avatar_small_url
  end
end
