FactoryGirl.define do
  factory :media_affiliate_campaign do
    use_stripe false
recipient_name "MyString"
media_affiliate_id 1
community_id 1
  end

end
