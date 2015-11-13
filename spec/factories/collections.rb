FactoryGirl.define do
  factory :collection do
    association :owner, factory: :merchant
  end
end