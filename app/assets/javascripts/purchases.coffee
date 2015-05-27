CakeCouponBook.purchases ?= {}

class Purchase
  constructor: (form, resourceName, stripeKey, imagePath) ->
    @form = $(form)
    @name = resourceName
    @stripeHandler = @stripeCheckout(stripeKey, imagePath)

    @emailInput = @form.find('input#purchase_email_input')
    @cardTokenInput = @form.find('input#purchase_card_token_input')

    @button = $('.buy_button')

    @buttonClick()
    return

  stripeCheckout: (key, image)->
    self = this
    return StripeCheckout.configure(
      key: key
      image: image
      token: (token, args) ->
        self.emailInput.val token.email
        self.cardTokenInput.val token.id
        self.form.submit()
        return
    )

  openStripe: (amount)->
    @stripeHandler.open
      name: "Buy Now!"
      description: "#{@name}"
      amount: amount * 100
    return

  buttonClick: ->
    self = this

    @button.click (e)->
      amount = $(this).data('price')

      e.preventDefault()
      self.openStripe(amount)
      return
    return

CakeCouponBook.purchases.coupon_book = (form, resourceName, stripeKey, imagePath)->
  new Purchase(form, resourceName, stripeKey, imagePath)
  return