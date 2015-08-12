CakeCouponBook.validations ?= {}

customMethods = ->
  $.validator.addMethod "onlyletters", ((value, element, params) ->
    this.optional(element) || /^[a-z\s]+$/i.test(value)
  ), (params, element) ->
    "Please enter only letters."

  $.validator.addMethod "url", ((value, element, params) ->
    this.optional(element) || /^(?:(?:https?|ftp):\/\/)?(?:\S+(?::\S*)?@)?(?:(?!(?:10|127)(?:\.\d{1,3}){3})(?!(?:169\.254|192\.168)(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})))(?::\d{2,5})?(?:\/\S*)?$/i.test(value)
  ), (params, element) ->
    "Please enter a valid URL."

  $.validator.addMethod "minStrictPledgeLevels", ((value, element, params) ->
    min = $(element).closest('.pledge_level').find('.min_value').text().replace('$','').replace(',', '')
    this.optional(element) || parseInt(value) > parseInt(min)
  ), (params, element) ->
    min = $(element).closest('.pledge_level').find('.min_value').text().replace('$','')
    "Please enter a value greater than $" + min

  $.validator.addMethod "limitToIntegerRange", ((value, element, params) ->
    this.optional(element) || parseInt(value) < 9999999999
  ), (params, element) ->
    "Please enter a value smaller than $9999999999"

  $.validator.addMethod "minStrict", ((value, element, params) ->
    this.optional(element) || parseInt(value) > parseInt(params)
  ), jQuery.validator.format("Please enter a value greater than {0}")

  $.validator.addMethod "firstLastName", ((value, element, params) ->
    this.optional(element) || /^\w+\s+\w+$/i.test(value)
  ), (params, element) ->
    "Please enter First and Last Name."

  return

class IncompleteTemplate
  constructor: (options) ->
    @model = options.model
    @form = $(".formtastic.#{@model}")
    @status = options.status
    @deleteUrl = options.deleteUrl
    @message = "Are you sure you want to leave? \n Your changes will not be saved."

    @onWindowClosing()
    @init()
    return

  init: ->
    self = this
    if @status is 'Incomplete' and @formInvalid()
      #Turbolinks
      $(document).on "page:before-change", (e)->
        e.preventDefault()
        self.showMessage()
        return
      #Normal links
      $('a[data-no-turbolink="true"]').click (e)->
        e.preventDefault()
        self.showMessage()
        return
      #Closing page
      # window.onbeforeunload = ->
      #   e = $.Event('cake:page:closing')
      #   $(window).trigger e
      #   #return e.message || self.message if e.isDefaultPrevented()
      #   return
    return

  showMessage: ->
    r = confirm(@message)
    @deleteObject() if r
    return

  onWindowClosing: ->
    self = this
    $(window).on 'cake:page:closing', (e) ->
      e.preventDefault()
      self.deleteObject()
      return
    return

  formInvalid: ->
    eval("CakeCouponBook."+ @model + "s.validation()")
    return !@form.valid()
  
  deleteObject: ->
    self = this
    $.ajax
      url: @deleteUrl
      type: 'DELETE'
      success: (result) ->
        window.location = result
        return
    return


CakeCouponBook.validations.incomplete_template = (options)->
  new IncompleteTemplate(options)
  return

CakeCouponBook.validations.init = ->
  customMethods()
  CakeCouponBook.coupons.validation()
  CakeCouponBook.coupon_books.validation()
  CakeCouponBook.pictures.validation.init()
  CakeCouponBook.pr_boxes.validation()
  CakeCouponBook.users.validation()
  return