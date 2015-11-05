require 'rails_helper'

RSpec.describe CouponBook, type: :model do
  describe "Model validatity" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:organization_name) }
    it { should validate_presence_of(:template) }
    it { should validate_presence_of(:fundraiser) }

    it { should belong_to(:fundraiser) }
    
    it { should have_one(:community).dependent(:destroy) }
    it { should have_one(:video).dependent(:destroy) }

    it { should have_many(:affiliate_campaigns).through(:community) }
    it { should have_many(:affiliates).through(:affiliate_campaigns) }
    it { should have_many(:affiliate_purchases).through(:affiliate_campaigns) }
    it { should have_many(:affiliate_commissions).through(:affiliate_campaigns) }

    it { should accept_nested_attributes_for(:categories) }
  end
end