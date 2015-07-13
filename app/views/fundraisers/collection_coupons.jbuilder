json.array! @collection_coupons do |coupon|
  json.(coupon, :id, :title, :description, :promo_code, :url, :sponsor_name, :disabled)
  json.itemType 'COUPON'
end