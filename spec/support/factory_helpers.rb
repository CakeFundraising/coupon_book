module FactoryHelpers
  extend self

  def stripe_fee_cents(amount_cents)
    (amount_cents*(CakeCouponBook::STRIPE_FEE/100)).round + 30
  end

  def application_fee_cents(amount_cents)
    (amount_cents*(CakeCouponBook::APPLICATION_FEE/100)).round
  end

  def stripe_card_token(key)
    WebMock.disable!
    token = Stripe::Token.create(
      {
        card: {
          number: "4000000000000077",
          exp_month: 12,
          exp_year: 2018,
          cvc: "314"
        }
      }, 
      key
    )
    token.id
  end

  def stripe_bank_account_token
    WebMock.disable!
    token = Stripe::Token.create(
      bank_account: {
        country: "US",
        routing_number: "110000000",
        account_number: "000123456789",
      }
    )
    token.id
  end
end