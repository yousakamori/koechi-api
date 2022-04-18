json.items do
  json.array! @likes do |like|
    json.extract! like, :id, :title, :shortlink_path, :post_type, :posted_at
    json.extract! like.likable, :slug, :liked_count
    json.user do
      json.extract! like.likable.user, :id, :name, :username, :avatar_small_url
    end

    if like.likable_type == 'Note'
      json.space do
        json.extract! like.likable.space, :slug, :emoji
      end
    else
      json.space nil
    end
  end
end

json.next_page @likes.next_page
