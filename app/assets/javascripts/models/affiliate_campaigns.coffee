CakeCouponBook.affiliate_campaigns ?= {}

CakeCouponBook.affiliate_campaigns.validation = ->
  $('.formtastic.affiliate_campaign').validate(
    ignore: ":hidden:not(.uri_input)"
    errorElement: "span"
    errorPlacement: (error, element)->
      error.appendTo(element.closest('.input'))
      return
    invalidHandler: (event, validator)->
      picsContainer = $('.uri_input')
      picsContainer.each ->
        input = $(this).closest('.input')
        input.removeClass('hidden')
        input.find('.form-label').hide()
        return
      return
    rules:
      'affiliate_campaign[first_name]': 
        required: true
      'affiliate_campaign[last_name]': 
        required: true
      'affiliate_campaign[organization_name]': 
        required: true
      'affiliate_campaign[email]': 
        required: true
      'affiliate_campaign[phone]':
        required: true
        phoneUS: true
      'affiliate_campaign[url]': 
        required: true
      'affiliate_campaign[coupon_book_id]':
        required: true
      'affiliate_campaign[avatar_picture_attributes][uri]':
        required: true
      'affiliate_campaign[location_attributes][address]': 
        required: true
      'affiliate_campaign[location_attributes][city]': 
        required: true
      'affiliate_campaign[location_attributes][zip_code]': 
        required: true
      'affiliate_campaign[location_attributes][state_code]': 
        required: true
  )
  return

CakeCouponBook.affiliate_campaigns.preview = ->
  form = $('.formtastic.affiliate_campaign')
  select = form.find('select#affiliate_campaign_coupon_book_id')
  container = form.find('#campaign-preview')

  select.change ->
    book_id = this.value
    
    $.get "/affiliate_campaigns/book_preview?coupon_book_id=#{book_id}", (data) ->
      container.html data
      return
    return
  return
