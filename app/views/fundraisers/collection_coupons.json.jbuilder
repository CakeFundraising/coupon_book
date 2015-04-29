json.array! @collections_coupons do |coupon|
  json.(coupon, :id, :title, :position, :description, :promo_code, :url)
  json.sponsor do
    json.name "Sponsor Name"
  end
end