FactoryGirl.define do
  factory :charge do
    kind "Charge"
    stripe_id "MyString"
    balance_transaction_id "MyString"
    gross_amount_cents { rand(99999) }
    fee_cents { FactoryHelpers.stripe_fee_cents(gross_amount_cents) +  FactoryHelpers.application_fee_cents(gross_amount_cents) }
    net_amount_cents { gross_amount_cents - fee_cents }
    fee_details ""
    captured false
    paid false
  end

end
