json.notes do
  json.array! @notes do |note|
    json.extract! note, :id, :title, :body_text, :slug, :posted_at, :comments_count, :updated_at, :created_at
    json.is_mine note.mine?(@current_user)
    json.body_letters_count note.body_length
    json.user do
      json.extract! note.user, :id, :name, :username, :avatar_small_url
    end
  end
end

json.space do
  json.role @space.memberships.find_by(user_id: @current_user).role
end

json.next_page @notes.next_page
