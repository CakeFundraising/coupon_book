FactoryGirl.define do
  factory :purchase do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    zip_code { Faker::Address.zip_code }
    email{ Faker::Internet.safe_email }
    card_token { FactoryHelpers.stripe_card_token(Rails.configuration.stripe[:publishable_key]) }
    amount_cents { rand(99999) }
    association :purchasable, factory: :coupon_book

    factory :affiliate_purchase do
      association :purchasable, factory: :affiliate_campaign
    end
  end

end
