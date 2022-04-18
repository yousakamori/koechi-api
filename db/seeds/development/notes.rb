body_text = <<-BODY
  テストノートあいうえおかきくけこさしすせそ
BODY

body_json = <<-BODY
  {"type":"doc","content":[{"type":"heading","attrs":{"level":1},"content":[{"type":"text","text":"テストノート"}]},{"type":"orderedList","attrs":{"start":1},"content":[{"type":"listItem","content":[{"type":"paragraph","content":[{"type":"text","text":"あいうえお"}]}]},{"type":"listItem","content":[{"type":"paragraph","content":[{"type":"text","marks":[{"type":"highlight","attrs":{"color":null}}],"text":"かきくけこ"}]}]},{"type":"listItem","content":[{"type":"paragraph","content":[{"type":"text","text":"さしすせそ"}]}]}]}]}
BODY

1.upto(5) do |i|
  user = User.find i
  space = user.spaces.first
  1.upto(100) do |i|
    date = Time.current + i.day
    note = user.notes.create!(title: "テストのノート#{i}", body_text: body_text, body_json: body_json, body_updated_at: date,  posted_at: date, space_id: space.id)
  end
end