json.talks do
  json.array! @talks do |talk|
    json.extract! talk, :id, :title, :slug, :archived, :closed, :closed_at, :last_comment_created_at, :created_at,
                  :comments_count, :liked_count
    json.user do
      json.extract! talk.user, :id, :name, :username, :avatar_small_url
    end
  end
end

json.next_page @talks.next_page
