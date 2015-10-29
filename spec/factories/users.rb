FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    url { Faker::Internet.url }
    organization_name { Faker::Name.name }
    type 'User'

    factory :fundraiser do
      type 'Fundraiser'
    end

    factory :merchant do
      type 'Merchant'      
    end

    factory :affiliate do
      type 'Affiliate'
    end

    factory :media_affiliate do
      type 'MediaAffiliate'
    end
  end
end
