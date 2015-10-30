FactoryGirl.define do
  factory :purchase do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    zip_code { Faker::Address.zip_code }
    email{ Faker::Internet.safe_email }
    amount_cents { rand(99999) }
    #card_token { FactoryHelpers.stripe_card_token(Rails.configuration.stripe[:publishable_key]) }
    card_token 'dssdahdshagdsugsgd'
    association :purchasable, factory: :coupon_book

    after(:build) do |purchase, evaluator|
      purchase.charge = FactoryGirl.build(:charge, gross_amount_cents: purchase.amount_cents, fee_cents: purchase.send(:application_fee) + FactoryHelpers.stripe_fee_cents(purchase.amount_cents) )
    end

    factory :fr_media_purchase do
      after(:create) do |purchase, evaluator|
        create_list(:commission, 1, purchase: purchase, commissionable: FactoryGirl.create(:media_affiliate_campaign))
      end
    end

  end

end
