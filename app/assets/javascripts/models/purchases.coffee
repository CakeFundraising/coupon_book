CakeCouponBook.purchases ?= {}

class Stripe
  constructor: (publishable_key) ->
    @loadScript(publishable_key)
    return
  
  loadScript: (publishable_key)->
    if window.Stripe is undefined
      stripeJS = document.createElement('script')
      stripeJS.async = true
      stripeJS.src = 'https://js.stripe.com/v2/'
      stripeJS.type= 'text/javascript'
      stripeJS.onreadystatechange = ->
        if @readyState == 'complete'
          window.Stripe.setPublishableKey(publishable_key)
        return
      stripeJS.onload = ->
        #console.log 'Stripe Loaded'
        window.Stripe.setPublishableKey(publishable_key)
        return
      s = document.getElementsByTagName('script')[0]
      s.parentNode.insertBefore(stripeJS, s)
    return

class Purchase
  constructor: (form, amount, publishable_key) ->
    @form = $(form)
    @submitButton = @form.find('input[type="submit"]')
    @cardTokenInput = @form.find('input#purchase_card_token_input')

    @amount = amount
    @stripeKey = publishable_key
    @stripe = new Stripe(publishable_key)

    @setUp()
    @onSubmit()
    return

  setUp: ->
    $('[data-toggle="tooltip"]').tooltip()
    CakeCouponBook.validations.customMethods()
    @validation()
    return

  onSubmit: ->
    self = this
    @submitButton.click (e)->
      if self.form.valid()
        e.preventDefault()
        self.disableForm()
        self.createToken()
      return
    return

  createToken: ->
    self = this

    new Stripe(@stripeKey) if window.Stripe is undefined #Retry to load Stripe if missing

    window.Stripe.card.createToken @form, (status, response) ->
      if response.error
        # Show the errors on the form
        self.form.find('#payment-errors').text(response.error.message).removeClass('hidden')
        self.enableForm()
      else
        # response contains id and card, which contains additional card details
        token = response.id
        # Insert the token into the form so it gets submitted to the server
        self.cardTokenInput.val(token)
        #Remove credit card related data
        self.removeInputNames()
        # and submit
        self.form.get(0).submit()
      return
    return

  enableForm: ->
    @submitButton.prop 'disabled', false
    @form.find('fieldset').css('opacity', 1)
    return

  disableForm: ->
    @submitButton.prop 'disabled', true
    @form.find('fieldset').css('opacity', 0.5)
    return

  removeInputNames: ->
    inputs = @form.find('.cc_inputs input')
    inputs.each ->
      $(this).removeAttr("name")
      return
    return

  validation: ->
    self = this 
    @form.validate(
      errorElement: "span"
      rules:
        'purchase[amount]':
          required: true
          minStrictCurrency: self.amount
        'purchase[first_name]': 
          required: true
          onlyletters: true
        'purchase[last_name]': 
          required: true
          onlyletters: true
        'purchase[zip_code]':
          required: true
          digits: true
          zipcodeUS: true
        'purchase[email]':
          required: true
        'purchase[email_confirmation]':
          required: true
          equalTo: "#purchase_email"
        'purchase[card_number]':
          required: true
          creditcard: true
        'purchase[exp_month]':
          required: true
          digits: true
          maxlength: 2
          range: [1, 12]
        'purchase[exp_year]':
          required: true
          digits: true
          maxlength: 2
          range: [15, 99]
        'purchase[cvc]':
          required: true
          digits: true
          minlength: 3
          maxlength: 4
    )
    return

CakeCouponBook.purchases.coupon_book = (amount, publishable_key)->
  new Purchase('.formtastic.purchase', amount, publishable_key)
  return
