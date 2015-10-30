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

  describe "Charge" do
    it 'creates a charge' do
      expect{
        FactoryGirl.create(:purchase, should_notify: false)
      }.to change{ Charge.count }.by(1)
    end

    it 'stores the right gross amount' do
      purchase = FactoryGirl.create(:purchase, should_notify: false)
      charge = purchase.charge
      expect(charge.gross_amount_cents).to eql(purchase.amount_cents)
    end

    it 'stores the right fee' do
      purchase = FactoryGirl.create(:purchase, should_notify: false)
      charge = purchase.charge

      expected_fee = purchase.send(:application_fee) + FactoryHelpers.stripe_fee_cents(purchase.amount_cents)

      expect(charge.fee_cents).to eql(expected_fee)
    end

    it 'stores the right net amount' do
      purchase = FactoryGirl.create(:purchase, should_notify: false)
      charge = purchase.charge

      expected_fee = purchase.send(:application_fee) + FactoryHelpers.stripe_fee_cents(purchase.amount_cents)
      expected_net = purchase.amount_cents - expected_fee

      expect(charge.net_amount_cents).to eql(expected_net)
    end
  end


  describe "After Purchase actions" do
    context 'Campaign Purchase' do
      context 'in Campaign page' do
        it 'creates a FR commission' do
          expect{
            FactoryGirl.create(:purchase, should_notify: false)
          }.to change{ Commission.coupon_book_commissionable.count }.by(1)
        end

        it 'FR commission should have the total purchase amount' do
          purchase = FactoryGirl.create(:purchase, should_notify: false)
          commission = Commission.coupon_book_commissionable.last

          expect(commission.amount_cents).to equal(purchase.net_amount_cents)
          expect(commission.percentage).to equal(100)
        end

        it 'should update CouponBook raised amount attribute' do
          coupon_book = FactoryGirl.create(:coupon_book)

          expect(coupon_book.raised_cents).to equal(0)
          purchase = FactoryGirl.create(:purchase, purchasable: coupon_book, should_notify: false)
          expect(coupon_book.raised_cents).to equal(purchase.amount_cents)
        end
      end

      context "with Media Affiliate" do
        it 'creates a FR commission' do
          expect{
            FactoryGirl.create(:purchase, should_notify: false)
          }.to change{ Commission.coupon_book_commissionable.count }.by(1)
        end

        it 'creates a MediaAffiliate commission' do
          expect{
            FactoryGirl.create(:purchase, should_notify: false)
          }.to change{ Commission.media_commissionable.count }.by(1)
        end

        it 'should have the total purchase amount' do
          purchase = FactoryGirl.create(:purchase, should_notify: false)
          commission = Commission.coupon_book_commissionable.last
          expect(commission.amount_cents).to equal(purchase.net_amount_cents)
          expect(commission.percentage).to equal(100)
        end

        it 'should update CouponBook raised amount attribute' do
          coupon_book = FactoryGirl.create(:coupon_book)

          expect(coupon_book.raised_cents).to equal(0)
          purchase = FactoryGirl.create(:purchase, purchasable: coupon_book, should_notify: false)
          expect(coupon_book.raised_cents).to equal(purchase.amount_cents)
        end
      end
    end

    # describe 'AffiliateCampaign Purchase' do
    #   describe "in Campaign page" do
    #     it 'creates a FR commission and a Affiliate commission' do
    #       let(:creating_a_purchase) { -> { FactoryGirl.create(:affiliate_purchase, should_notify: false) } }

    #       expect(creating_a_recipe).to change{ Commission.coupon_book_commissionable.count }.by(1)
    #       expect(creating_a_recipe).to change{ Commission.affiliate_commissionable.count }.by(1)
    #     end

    #     it 'the Affilite commission should be specified by the AffiliateCampaign rate' do
    #       purchase = FactoryGirl.create(:affiliate_purchase, should_notify: false)
    #       affiliate_campaign = purchase.affiliate_campaign
    #       affiliate_commission = Commission.affiliate_commissionable.last

    #       expect(affiliate_commission.amount_cents).to equal(purchase.net_amount_cents)
    #       expect(affiliate_commission.percentage).to equal(affiliate_campaign.campaign_rate)
    #     end

    #     it 'should update CouponBook raised amount attribute' do
    #       coupon_book = FactoryGirl.create(:coupon_book)

    #       expect(coupon_book.raised_cents).to equal(0)
    #       purchase = FactoryGirl.create(:purchase, purchasable: coupon_book, should_notify: false)
    #       expect(coupon_book.raised_cents).to equal(purchase.amount_cents)
    #     end
    #   end
    # end

  end

end
