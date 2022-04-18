json.comments do
  json.array! @comments do |comment|
    json.extract! comment, :id, :commentable_id, :commentable_type, :parent_id, :slug, :created_at, :liked_count, :reply
    json.title comment.body_text.truncate(140)
    json.commentable do
      json.extract! comment.commentable, :id, :slug, :comments_count, :liked_count, :created_at, :updated_at
      json.title comment.commentable.title.truncate(40)
    end
  end
end

json.next_page @comments.next_page
