json.spaces do
  json.array! @spaces do |space|
    json.extract! space, :id, :name, :emoji, :slug
  end
end
