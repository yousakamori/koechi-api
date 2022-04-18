json.member do
  json.extract! @user, :id, :name, :username, :avatar_small_url, :role
  json.is_owner @user == @space.owner
end
