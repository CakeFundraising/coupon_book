json.array! @collection_coupons do |coupon|
  json.(coupon, :id, :title, :description, :promo_code, :url)
  json.disabled coupon.disabled
end