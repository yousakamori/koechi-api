json.notes do
  json.array! @notes do |note|
    json.extract! note, :id, :title, :body_text, :body_json, :slug, :body_updated_at, :posted_at,
                  :last_comment_created_at, :liked_count, :comments_count, :updated_at, :created_at

    json.is_mine note.mine?(@current_user)
    json.body_letters_count note.body_length

    json.user do
      json.extract! note.user, :id, :name, :username, :avatar_small_url
    end

    json.space do
      json.slug note.space.slug
      json.emoji note.space.emoji
      json.role note.space.memberships.find { |m| m.user_id == @current_user.id }.role
    end
  end
end
