body_text = <<-BODY
  テストノートあいうえおかきくけこさしすせそ
BODY

body_json = <<-BODY
  {"type":"doc","content":[{"type":"heading","attrs":{"level":1},"content":[{"type":"text","text":"テストノート"}]},{"type":"orderedList","attrs":{"start":1},"content":[{"type":"listItem","content":[{"type":"paragraph","content":[{"type":"text","text":"あいうえお"}]}]},{"type":"listItem","content":[{"type":"paragraph","content":[{"type":"text","marks":[{"type":"highlight","attrs":{"color":null}}],"text":"かきくけこ"}]}]},{"type":"listItem","content":[{"type":"paragraph","content":[{"type":"text","text":"さしすせそ"}]}]}]}]}
BODY


1.upto(5) do |i|
  user = User.find i
  space = user.spaces.create!(emoji: "🙃", name: "スペース#{i}", owner_id: user.id)
  space.memberships.find_by(user_id: user).admin!

  1.upto(100) do |i|
    note = space.notes.create!(title: "ノートのタイトル", body_text: body_text, body_json: body_json, posted_at: Time.current, user_id: user.id)
  end
end
