json.array! @categories do |category|
  json.(category, :id, :name, :position)
  json.coupons category.coupons
end