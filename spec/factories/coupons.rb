FactoryGirl.define do
  factory :coupon do
    title { Faker::Lorem.sentence }
    expires_at { Time.now + 3.months }
    promo_code { rand(9999) }
    description { Faker::Lorem.paragraph }
    price_cents { rand(9999) }
    url { Faker::Internet.url }
    phone { Faker::PhoneNumber.phone_number }
    sponsor_name { Faker::Company.name }
    merchandise_categories { Coupon::CATEGORIES.sample(3) }
    status :launched
    association :origin_collection, factory: :collection
    picture

    factory :pr_box do
      type 'PrBox'
    end

  end
end