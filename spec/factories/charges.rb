FactoryGirl.define do
  factory :charge do
    stripe_id "MyString"
balance_transaction_id "MyString"
kind "MyString"
amount ""
total_fee ""
paid false
captured false
fee_details ""
chargeable_type "MyString"
chargeable_id 1
  end

end
