FactoryGirl.define do
  factory :media_affiliate_campaign do
    recipient_name { Faker::Name.name }
    commission_percentage { rand(0..50) }
    media_affiliate
    community
  end

end
