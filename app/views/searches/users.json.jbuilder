json.users do
  json.array! @users do |user|
    json.extract! user, :id, :name, :username, :avatar_small_url
  end
end

json.next_page @users.next_page
