CakeCouponBook.couponBookBuilder ?= {}

CakeCouponBook.couponBookBuilder.init = (couponBookId)->
  categoriesSource = "/coupon_books/#{couponBookId}/categories.json"
  collectionSource = '/fundraisers/collection_coupons.json'

  React.render(`<CategoryList source={categoriesSource} />`,$('#categories')[0]);
  React.render(`<CouponCollection source={collectionSource} />`, $('#collection-coupons')[0]);
  return