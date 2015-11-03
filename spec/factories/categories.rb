FactoryGirl.define do
  factory :category do
    sequence(:name){|n| "Category #{n}" }

    factory :category_with_coupons do
      after(:create) do |category, evaluator|
        FactoryGirl.create_list(:categories_coupon, 3, category: category)
        FactoryGirl.create_list(:categories_coupon, 2, category: category, coupon: FactoryGirl.create(:pr_box))
      end
    end
  end
end