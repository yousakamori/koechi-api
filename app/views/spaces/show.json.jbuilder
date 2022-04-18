json.space do
  json.extract! @space, :id, :name, :emoji, :slug, :archived, :notes_count, :updated_at, :created_at
  json.is_mine @space.owner == @current_user
  json.role @space.memberships.find_by(user_id: @current_user).role
  json.user do
    json.extract! @space.owner, :id, :name, :username, :avatar_small_url
  end
end
