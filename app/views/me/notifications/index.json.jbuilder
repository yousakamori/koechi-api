json.items do
  json.array! @notifications do |notification|
    json.extract! notification, :id, :action, :action_text, :notifiable_slug, :notifiable_title, :notifiable_type
    json.datetime notification.updated_at

    json.sender do
      json.extract! notification.sender, :id, :name, :username, :avatar_small_url
    end
  end
end

json.next_page @notifications.next_page
