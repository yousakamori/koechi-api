json.users do
  json.array! @follows do |follow|
    json.id follow.following.id
    json.username follow.following.username
    json.name follow.following.name
    json.avatar_small_url follow.following.avatar_small_url
  end
end
json.next_page @follows.next_page
