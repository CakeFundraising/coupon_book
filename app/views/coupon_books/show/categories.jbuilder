json.array! @categories do |category|
  json.(category, :id, :name, :position)
  json.items category.items do |item|
    json.id item.id
    json.title item.title
    json.position item.position
    json.item_type item.class.name
  end
end