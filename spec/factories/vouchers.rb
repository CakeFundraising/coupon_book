FactoryGirl.define do
  factory :voucher do
    number { rand(9999999).to_s }
    expires_at { Time.now + 4.months }
    categories_coupon
    association :purchase, factory: :mock_purchase

    factory :redeemed_voucher do
      status :redeemed
    end

    factory :expired_voucher do
      expires_at { Time.now - 4.months }
    end
  end
end