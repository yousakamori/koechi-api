json.users do
  json.array! @followings do |following|
    json.id following.following.id
    json.username following.following.username
    json.name following.following.name
    json.avatar_small_url following.following.avatar_small_url
  end
end
json.next_page @followings.next_page
