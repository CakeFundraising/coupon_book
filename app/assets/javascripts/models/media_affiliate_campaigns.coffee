CakeCouponBook.media_affiliate_campaigns ?= {}

CakeCouponBook.media_affiliate_campaigns.validation = ->
  $('.formtastic.media_affiliate_campaign').validate(
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
      'media_affiliate_campaign[community_id]':
        required: true
      'media_affiliate_campaign[commission_percentage]':
        required: true
      'media_affiliate_campaign[recipient_name]': 
        required: true
      'media_affiliate_campaign[location_attributes][address]': 
        required: true
      'media_affiliate_campaign[location_attributes][city]': 
        required: true
      'media_affiliate_campaign[location_attributes][zip_code]': 
        required: true
      'media_affiliate_campaign[location_attributes][state_code]': 
        required: true
  )
  return

CakeCouponBook.media_affiliate_campaigns.preview = ->
  form = $('.formtastic.media_affiliate_campaign')
  select = form.find('select#media_affiliate_campaign_community_id')
  container = form.find('#campaign-preview')

  select.change ->
    book_id = this.value
    
    $.get "/media_campaigns/book_preview?community_id=#{book_id}", (data) ->
      container.html data
      return
    return
  return
