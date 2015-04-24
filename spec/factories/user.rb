FactoryGirl.define do
  factory :user do
    full_name { Faker::Name.name }
    email { Faker::Internet.email }
    cake_access_token { SecureRandom.base64(32) }
    fundraiser

    factory :fr_user do
      fundraiser
    end

    factory :sp_user do
      sponsor
    end
  end
end