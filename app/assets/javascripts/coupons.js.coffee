CakeCouponBook.coupons ?= {}

CakeCouponBook.coupons.validation = ->
  jQuery.validator.addClassRules
    coupon_title:
      required: true
    coupon_expires_at:
      required: true
    coupon_description:
      required: true
#    coupon_merchandise_categories:
#      required: true
    coupon_terms_conditions:
      required: true
#    max_value:
#      required: true
#      number: true
#      minStrictPledgeLevels: true

  $('.formtastic.coupon').validate(
    errorElement: "span"
  )
  return