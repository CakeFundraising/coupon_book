json.array! @collection_coupons do |coupon|
  json.(coupon, :id, :title, :description, :promo_code, :url, :disabled)
  json.itemType 'COUPON'
  json.sponsorName coupon.sponsor_name
end