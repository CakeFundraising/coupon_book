FactoryGirl.define do
  factory :media_affiliate_campaign do
    recipient_name { Faker::Name.name }
    media_affiliate
    community
  end

end
