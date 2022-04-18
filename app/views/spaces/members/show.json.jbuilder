json.members do
  json.array! @members do |member|
    json.extract! member.user, :id, :name, :username, :avatar_small_url
    json.is_owner member.user == @space.owner
    json.role member.role
  end
end

json.space do
  json.role @members.find_by(user_id: @current_user).role
end
