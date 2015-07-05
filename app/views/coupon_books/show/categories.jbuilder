json.array! @categories do |category|
  json.(category, :id, :name, :position)
  json.items category.items do |item|
    json.id item.id
    json.title item.title
    json.position item.position
    json.itemType item.class.name.upcase
    json._destroy false
    json.saved true
  end
end