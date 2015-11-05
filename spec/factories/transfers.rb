FactoryGirl.define do
  factory :transfer do
    stripe_id "MyString"
    balance_transaction_id "MyString"
    kind "MyString"
    amount ""
    total_fee ""
    status "MyString"
    transferable nil
  end

end
