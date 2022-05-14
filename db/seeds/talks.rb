def random_user
  User.find(User.ids[rand(User.count)])
end

def create_comment!(talk)
  body_text = <<-BODY
    コメントみんなで話し合いましょう
  BODY

  body_json = <<-BODY
    {"type":"doc","content":[{"type":"heading","attrs":{"level":1},"content":[{"type":"text","text":"コメント"}]},{"type":"paragraph","content":[{"type":"text","text":"みんなで話し合いましょう"}]}]}
  BODY

  5.times do
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

1.upto(50) do |i|
  talk_user = random_user
  talk = talk_user.talks.create!(title: "タイトル#{i}")
  create_comment!(talk)
end
