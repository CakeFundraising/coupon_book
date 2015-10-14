CakeCouponBook.communities ?= {}

CakeCouponBook.communities.validation = ->
  $('.formtastic.community').validate(
    errorElement: "span"
    rules:
      'community[slug]':
        required: true
      'community[affiliate_commission_percentage]':
        required: true
      'community[media_commission_percentage]':
        required: true
  )
  warnAffiliateRateIncrease()
  return

warnAffiliateRateIncrease = ->
  selectBox = $('.formtastic.community #community_affiliate_commission_percentage')
  warningAlert = $('.formtastic.community .alert.alert-warning')
  
  previousValue = selectBox.val()
  warningAlert.hide()

  selectBox.change ->
    newValue = $(this).val()

    if newValue > previousValue
      warningAlert.show()
    else
      warningAlert.hide()
    return
  return