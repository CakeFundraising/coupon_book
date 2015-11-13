FactoryGirl.define do
  factory :coupon_book do
    name { Faker::Lorem.sentence }
    title { Faker::Lorem.sentence }
    headline { Faker::Lorem.sentence }
    story { Faker::Lorem.paragraph }
    mission { Faker::Lorem.paragraph }
    organization_name { Faker::Name.name }
    launch_date { Time.now + 3.days }
    end_date { Time.now + 4.months }
    causes { CouponBook::CAUSES.sample(5) }
    main_cause { CouponBook::CAUSES.sample }
    scopes { CouponBook::SCOPES.sample(2) }
    goal_cents {rand(999) + 10000 }
    price_cents {rand(999) + 10000 }
    status :launched
    fundraiser
    picture

    factory :incomplete_campaign do
      status :incomplete
    end

    factory :past_campaign do
      status :past
      launch_date { Time.now - 4.months }
      end_date { Time.now - 2.months }
    end

    factory :coupon_book_with_coupons do
      after(:create) do |coupon_book, evaluator|
        FactoryGirl.create(:category_with_coupons, coupon_book: coupon_book)
      end
    end

  end
end