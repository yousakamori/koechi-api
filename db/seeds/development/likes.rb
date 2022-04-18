100.times do
  user = User.find(User.ids[rand(User.count)])
  likable_type = "Talk"
  likable_id = Talk.ids[rand(Talk.count)]

  user.likes.create!(
    liked: true,
    likable_type: likable_type,
    likable_id: likable_id
  )
end