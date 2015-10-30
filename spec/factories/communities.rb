FactoryGirl.define do
  factory :community do
    slug "MyString"
    affiliate_commission_percentage { rand(99) + 1 }
    media_commission_percentage { 100 - affiliate_commission_percentage }
    coupon_book
  end

end
