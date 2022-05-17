users = [
  { name: 'つけめん太郎', username: 'taro', password: 'koechi@password' },
  { name: 'ラーメン二郎', username: 'jiro', password: 'koechi@password' },
  { name: 'はな', username: 'hana', password: 'koechi@password' },
  { name: 'ジョン・レノン', username: 'john', password: 'koechi@password' },
  { name: 'マイク・タイソン', username: 'mike', password: 'koechi@password' },
  { name: 'ソフィー', username: 'sophy', password: 'koechi@password' },
  { name: 'ビル・ゲイツ', username: 'bill', password: 'koechi@password' },
  { name: 'アレクサンダーリーチャン', username: 'alex', password: 'koechi@password' },
  { name: 'マリー・アントワネット', username: 'mary', password: 'koechi@password' },
  { name: 'トム・ペニー', username: 'tom', password: 'koechi@password' },
  { name: 'げすとゆーざー', username: 'guestuser', password: 'password', role: 10 }
]

users.each_with_index do |u, i|
  user = User.create(
    name: u[:name],
    username: u[:username],
    bio: "どうも#{u[:username]}です🙏 https://www.youtube.com/",
    email: "#{u[:username]}@example.com",
    password: u[:password],
    activated_at: Time.current
  )

  filename = "user#{i + 1}.png"
  path = Rails.root.join("db/seeds/images/#{filename}").to_s
  user.avatar.attach(io: File.open(path), filename: filename)
end
