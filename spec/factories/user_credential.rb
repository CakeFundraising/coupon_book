class UserCredential
end

FactoryGirl.define do
  factory :user_credential do
    email 'success@example.com'
    password 'success_password'

    factory :invalid_credential do
      email 'invalid@example.com'
      password 'invalid_password'
    end
  end
end