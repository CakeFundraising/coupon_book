FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    organization_name { Faker::Name.name }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.phone_number }
    url { Faker::Internet.url }
    password 'password'
    type 'User'

    factory :fundraiser, class: Fundraiser do
      type 'Fundraiser'
      stripe_account
    end

    factory :merchant, class: Merchant do
      type 'Merchant'      
    end

    factory :affiliate, class: Affiliate do
      type 'Affiliate'
      stripe_account
    end

    factory :media_affiliate, class: MediaAffiliate do
      type 'MediaAffiliate'
      stripe_account
    end
  end
end
