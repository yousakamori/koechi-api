json.talk do
  json.extract! @talk, :id, :title, :slug, :archived, :closed, :closed_at, :last_comment_created_at, :created_at,
                :comments_count, :liked_count
end
