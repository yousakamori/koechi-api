body_text = <<-BODY
  good morning taro.
  what's up
  what's up
  what's up
BODY

body_json = <<-BODY
  {"type":"doc","content":[{"type":"heading","attrs":{"level":1},"content":[{"type":"text","text":"good morning taro."}]},{"type":"paragraph","content":[{"type":"text","text":"what's up"}]},{"type":"paragraph","content":[{"type":"text","text":"what's up"}]},{"type":"paragraph","content":[{"type":"text","text":"what's up"}]},{"type":"paragraph"},{"type":"paragraph"}]}
BODY

def random_user
  User.find(rand(5) + 1)
end

1.upto(50) do |i|
  talk_user = random_user
  talk = talk_user.talks.create!(title: "タイトル#{i}")

  10.times do
    # comment
    comment_user = random_user
    parent_comment = talk.comments.create!(
      body_text: body_text,
      body_json: body_json,
      user: comment_user
    )
    10.times do
      # comment reply
      child_comment_user = random_user
      talk.comments.create!(
        body_text: body_text,
        body_json: body_json,
        user: child_comment_user,
        parent_id: parent_comment.id
      )
    end
  end
end
