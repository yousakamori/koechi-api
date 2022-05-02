json.notes do
  json.array! @notes do |note|
    json.extract! note, :id, :title, :body_text, :slug, :posted_at, :comments_count, :created_at

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

json.next_page @notes.next_page
