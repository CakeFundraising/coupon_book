json.array! @categories do |category|
  json.(category, :id, :name, :position)
  json.items category.categories_coupons do |categories_coupon|
    json.collection_id categories_coupon.id
    json.itemType categories_coupon.coupon.type.upcase
    json.id categories_coupon.coupon.id
    json.title categories_coupon.coupon.title
    json.position categories_coupon.position
    json._destroy false
    json.saved true
  end
end