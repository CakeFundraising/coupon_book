CakeCouponBook.couponBookBuilder ?= {}

CakeCouponBook.couponBookBuilder.init = (couponBookId)->
  categoriesSource = "/coupon_books/#{couponBookId}/categories.json"
  collectionSource = '/fundraisers/collection_coupons.json'

  React.render(`<CategoryList source={categoriesSource} />`, document.getElementById('categories'));
  React.render(`<CouponCollection source={collectionSource} />`, document.getElementById('collection-coupons'));
  return