json.note do
  json.extract! @note, :id, :title, :body_text, :body_json, :posted_at
end
