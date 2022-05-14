body_text = <<-BODY
  テストノートあいうえおかきくけこさしすせそ
BODY

body_json = <<-BODY
  {"type":"doc","content":[{"type":"heading","attrs":{"level":1},"content":[{"type":"text","text":"テストノート"}]},{"type":"orderedList","attrs":{"start":1},"content":[{"type":"listItem","content":[{"type":"paragraph","content":[{"type":"text","text":"あいうえお"}]}]},{"type":"listItem","content":[{"type":"paragraph","content":[{"type":"text","marks":[{"type":"highlight","attrs":{"color":null}}],"text":"かきくけこ"}]}]},{"type":"listItem","content":[{"type":"paragraph","content":[{"type":"text","text":"さしすせそ"}]}]}]}]}
BODY

spaces = [
  { emoji: '🌼', name: 'デイサービス' },
  { emoji: '🧈', name: 'ショートステイ' },
  { emoji: '🐸', name: 'ケアマネジャー' },
  { emoji: '🏥', name: '通院' }
]

usernames = %w[taro jiro testuser]
now = Time.current

usernames.each do |n|
  user = User.find_by(username: n)
  spaces.each do |s|
    space = user.spaces.create!(emoji: s[:emoji], name: s[:name], owner_id: user.id)
    space.memberships.find_by(user_id: user).admin!
    1.upto(90) do |i|
      space.notes.create!(title: 'ノートのタイトル', body_text: body_text, body_json: body_json, posted_at: now.since(i.days), user_id: user.id)
    end
  end
end
