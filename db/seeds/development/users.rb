names = %w(taro jiro hana john mike sophy bill alex mary tom)

0.upto(9) do |i|
  user = User.create(
    name: names[i],
    username: names[i],
    bio: "どうも#{names[i]}です😁",
    email: "#{names[i]}@example.com",
    password: "password",
    activated_at: Time.current
  )

  filename = "user#{i % 3 + 1}.png"
  path = Rails.root.join("db/seeds/development/images/#{filename}").to_s
  user.avatar.attach(io: File.open(path), filename: filename)
end