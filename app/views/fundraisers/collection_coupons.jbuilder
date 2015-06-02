json.array! @collections_coupons do |coupon|
  json.(coupon, :id, :title, :description, :promo_code, :url)
end