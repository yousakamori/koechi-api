json.users do
  json.array! @followers do |follower|
    json.id follower.follower.id
    json.username follower.follower.username
    json.name follower.follower.name
    json.avatar_small_url follower.follower.avatar_small_url
  end
end
json.next_page @followers.next_page
