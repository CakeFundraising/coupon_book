FactoryGirl.define do
  factory :coupon_book do
    name { Faker::Lorem.sentence }
    title { Faker::Lorem.sentence }
    headline { Faker::Lorem.sentence }
    story { Faker::Lorem.paragraph }
    mission { Faker::Lorem.paragraph }
    launch_date { Time.now + 3.days }
    end_date { Time.now + 4.months }
    goal {rand(999) + 1 }
    causes { CouponBook::CAUSES.sample(5) }
    main_cause { CouponBook::CAUSES.sample }
    scopes { CouponBook::SCOPES.sample(2) }
    picture
    fundraiser
    status :launched

    factory :incomplete_campaign do
      status :incomplete
    end

    factory :past_campaign do
      status :past
      launch_date { Time.now - 4.months }
      end_date { Time.now - 2.months }
    end
  end
end