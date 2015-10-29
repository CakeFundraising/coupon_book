require 'rails_helper'

RSpec.describe Purchase, type: :model do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:zip_code) }
  it { should validate_presence_of(:purchasable) }
  it { should validate_presence_of(:card_token) }
  it { should validate_presence_of(:amount_cents) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:token) }

  it { should belong_to(:purchasable) }
  it { should have_one(:charge).dependent(:destroy) }

  it { should have_many(:commissions).dependent(:destroy) }
  it { should have_many(:vouchers).dependent(:destroy) }

  it { should accept_nested_attributes_for(:commissions) }

  
end
