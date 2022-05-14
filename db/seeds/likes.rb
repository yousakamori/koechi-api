1.upto(17) do |i|
  talk = Talk.find(i)
  User.ids.each do |id|
    user = User.find(id)
    user.likes.create!(
      liked: true,
      likable_type: 'Talk',
      likable_id: talk.id
    )
  end
end

100.times do
  user = User.find(User.ids[rand(User.count)])
  likable_id = Talk.ids[rand(Talk.count)]
  user.likes.create!(
    liked: true,
    likable_type: 'Talk',
    likable_id: likable_id
  )
end
