FactoryGirl.define do
  factory :affiliate_campaign do
    organization_name { Faker::Name.name }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone { Faker::PhoneNumber.phone_number }
    email { Faker::Internet.email }
    story { Faker::Lorem.paragraph }
    url { Faker::Internet.url }
    coupon_book
    affiliate
    community
  end

end
