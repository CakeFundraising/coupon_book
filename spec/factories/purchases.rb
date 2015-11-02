FactoryGirl.define do
  factory :purchase do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    zip_code { Faker::Address.zip_code }
    email{ Faker::Internet.safe_email }
    amount_cents { rand(99999) }
    card_token { FactoryHelpers.stripe_card_token }
    association :purchasable, factory: :coupon_book
    should_notify false

    factory :fr_media_purchase do
      after(:build) do |purchase, evaluator|
        purchase.commissions << FactoryGirl.build(:commission, purchase: purchase, commissionable: FactoryGirl.create(:media_affiliate_campaign))
      end
    end

    factory :affiliate_campaign_purchase do
      association :purchasable, factory: :affiliate_campaign

      after(:build) do |purchase, evaluator|
        purchase.commissions << FactoryGirl.build(:commission, purchase: purchase, commissionable: FactoryGirl.create(:affiliate_campaign))
      end

    end

    factory :affiliate_community_purchase do
      association :purchasable, factory: :affiliate_campaign

      after(:build) do |purchase, evaluator|
        purchase.commissions << FactoryGirl.build(:commission, purchase: purchase, commissionable: FactoryGirl.create(:affiliate_campaign, community_rate: 60), fcp: '1')
      end

      factory :affiliate_and_media_community_purchase do
        after(:build) do |purchase, evaluator|
          purchase.commissions << FactoryGirl.build(:commission, purchase: purchase, commissionable: FactoryGirl.create(:media_affiliate_campaign, commission_percentage: 20))
        end
      end
    end

  end

end
