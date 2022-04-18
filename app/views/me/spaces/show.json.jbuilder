json.spaces do
  json.array! @spaces do |space|
    json.extract! space, :id, :name, :emoji, :slug, :archived, :favorite, :notes_count, :updated_at, :created_at

    json.is_mine space.owner == @current_user

    json.user do
      json.extract! space.owner, :id, :name, :username, :avatar_small_url
    end

    json.members do
      json.array! space.memberships do |member|
        json.extract! member.user, :id, :name, :username, :avatar_small_url
        json.is_owner member.user == space.owner
        json.role member.role
      end
    end
  end
end
