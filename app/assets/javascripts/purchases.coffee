CakeCouponBook.purchases ?= {}

class Purchase
  constructor: (form) ->
    @form = $(form)
    @submitButton = @form.find('input[type="submit"]')
    @cardTokenInput = @form.find('input#purchase_card_token_input')
    @overlay = $('#buy_book_modal .overlay')

    @validation()
    @onSubmit()
    return

  onSubmit: ->
    self = this
    @form.submit (event) ->
      $form = $(this)

      if $form.valid()
        # Disable the submit button to prevent repeated clicks
        self.submitButton.prop 'disabled', true

        self.overlay.css('z-index', 1)

        self.createToken()
      # Prevent the form from submitting with the default action
      return false
    return

  createToken: ->
    self = this
    Stripe.card.createToken @form, (status, response) ->
      if response.error
        # Show the errors on the form
        self.form.find('#payment-errors').text(response.error.message).removeClass('hidden')
        self.submitButton.prop 'disabled', false
        self.overlay.css('z-index', 0)
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

  removeInputNames: ->
    inputs = @form.find('.cc_inputs input')
    inputs.each ->
      $(this).removeAttr("name")
      return
    return

  validation: ->
    @form.validate(
      errorElement: "span"
      rules:
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
        'purchase[cc_number]':
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

CakeCouponBook.purchases.coupon_book = (form)->
  new Purchase(form)
  return
