json.users do
  json.array! @users do |user|
    json.id user.id
    json.username user.username
    json.name user.name
    json.avatar_small_url user.avatar_small_url
  end
end
