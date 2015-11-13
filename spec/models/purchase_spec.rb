require 'rails_helper'

RSpec.describe Purchase, type: :model do
  describe "Model validity" do
    subject { FactoryGirl.build(:purchase, should_charge: false, card_token: 'sdasdasdasd') }

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

  describe "Model methods" do
    let(:stripe_helper) { StripeMock.create_test_helper }
    before { StripeMock.start }
    after { StripeMock.stop }

    describe "#update_purchasable_raised!" do
      it 'should update the CouponBook raised attribute' do
        coupon_book = FactoryGirl.create(:coupon_book)
        purchase = FactoryGirl.build(:purchase, purchasable: coupon_book)

        expect{
          purchase.update_purchasable_raised!
        }.to change{ coupon_book.raised_cents }.by(purchase.amount_cents)
      end

      it 'should not touch the CouponBook Community object' do
        coupon_book = FactoryGirl.create(:coupon_book)
        community = FactoryGirl.create(:community, coupon_book: coupon_book)
        purchase = FactoryGirl.build(:purchase, purchasable: coupon_book)

        expect{
          purchase.update_purchasable_raised!
        }.to_not change{ community.updated_at }
      end

      it 'should update the AffiliateCampaign raised attribute' do
        affiliate_campaign = FactoryGirl.create(:affiliate_campaign)
        purchase = FactoryGirl.build(:purchase, purchasable: affiliate_campaign)

        expect{
          purchase.update_purchasable_raised!
        }.to change{ affiliate_campaign.raised_cents }.by(purchase.amount_cents)
      end

      it 'should touch the AffiliateCampaign Community object' do
        affiliate_campaign = FactoryGirl.create(:affiliate_campaign)
        purchase = FactoryGirl.build(:purchase, purchasable: affiliate_campaign)

        expect{
          purchase.update_purchasable_raised!
        }.to change{ affiliate_campaign.community.updated_at }
      end
    end #End-update_purchasable_raised!

    describe "#create_vouchers!" do
      let(:stripe_helper) { StripeMock.create_test_helper }
      before { StripeMock.start }
      after { StripeMock.stop }

      let!(:purchase) { FactoryGirl.create(:purchase, purchasable: FactoryGirl.create(:coupon_book_with_coupons)) }

      it 'should create vouchers if none present' do
        expect{
          purchase.create_vouchers!
        }.to change{ purchase.vouchers.count }
      end

      it 'should not create new vouchers if any already present' do
        purchase.create_vouchers!

        expect{
          purchase.create_vouchers!
        }.to_not change{ purchase.vouchers.count }
      end

      it 'should create one voucher per coupon' do
        coupon_book = purchase.purchasable
        purchase.create_vouchers!

        expect(coupon_book.coupons.count).to eql(coupon_book.vouchers.count)
      end
    end

  end

  describe "Charge" do
    let(:stripe_helper) { StripeMock.create_test_helper }
    before { StripeMock.start }
    after { StripeMock.stop }

    let!(:purchase) { FactoryGirl.create(:purchase) }
    let!(:charge) { purchase.charge }

    it 'creates a charge object' do
      expect{
        FactoryGirl.create(:purchase)
      }.to change{ Charge.count }.by(1)
    end

    it 'stores the right gross amount' do
      expect(charge.gross_amount_cents).to eql(purchase.amount_cents)
    end

    it 'stores the right fee' do
      expected_fee = purchase.send(:application_fee) + FactoryHelpers.stripe_fee_cents(purchase.amount_cents)

      expect(charge.fee_cents).to eql(expected_fee)
    end

    it 'stores the right net amount' do
      expected_fee = purchase.send(:application_fee) + FactoryHelpers.stripe_fee_cents(purchase.amount_cents)
      expected_net = purchase.amount_cents - expected_fee

      expect(charge.net_amount_cents).to eql(expected_net)
    end
  end

  describe "Commissions" do
    let(:stripe_helper) { StripeMock.create_test_helper }
    before { StripeMock.start }
    after { StripeMock.stop }

    context 'Campaign page' do
      context 'No Media Affiliate' do
        let!(:purchase) { FactoryGirl.create(:purchase) }

        it 'creates a FR commission' do
          expect{
            FactoryGirl.create(:purchase)
          }.to change{ Commission.coupon_book_commissionable.count }.by(1)
        end

        it 'FR commission should have the total purchase amount' do
          commission = Commission.coupon_book_commissionable.last

          expect(commission.amount_cents).to equal(purchase.net_amount_cents)
          expect(commission.percentage).to equal(100)
        end
      end

      context 'with Media Affiliate' do
        it 'creates a FR commission' do
          expect{
            FactoryGirl.create(:fr_media_purchase)
          }.to change{ Commission.coupon_book_commissionable.count }.by(1)
        end

        it 'creates a MediaAffiliate commission' do
          expect{
            FactoryGirl.create(:fr_media_purchase)
          }.to change{ Commission.media_commissionable.count }.by(1)
        end

        it 'the MediaAffiliate commission should store the right amount' do
          purchase = FactoryGirl.create(:fr_media_purchase)
          commission = Commission.media_commissionable.last

          expected_percentage = commission.commissionable.commission_percentage
          expected_commission = ((expected_percentage*purchase.net_amount_cents)/100.0).floor

          expect(commission.amount_cents).to equal(expected_commission)
          expect(commission.percentage).to equal(expected_percentage)
        end

        it 'the FR commission should store the amount remaining' do
          purchase = FactoryGirl.create(:fr_media_purchase)

          media_commission = Commission.media_commissionable.last
          fr_commission = Commission.coupon_book_commissionable.last

          expected_percentage = 100 - media_commission.percentage
          expected_commission = ((expected_percentage*purchase.net_amount_cents)/100.0).floor

          expect(fr_commission.amount_cents).to equal(expected_commission)
          expect(fr_commission.percentage).to equal(expected_percentage)
        end
      end

    end #End Campaign page

    context "Affiliate Campaign page" do
      context 'No Media Affiliate' do
        it 'creates a FR commission' do
          expect{
            FactoryGirl.create(:affiliate_campaign_purchase)
          }.to change{ Commission.coupon_book_commissionable.count }.by(1)
        end

        it 'creates a Affiliate commission' do
          expect{
            FactoryGirl.create(:affiliate_campaign_purchase)
          }.to change{ Commission.affiliate_commissionable.count }.by(1)
        end

        it 'the Affiliate commission should store the right amount' do
          purchase = FactoryGirl.create(:affiliate_campaign_purchase)
          commission = Commission.affiliate_commissionable.last

          expected_percentage = commission.commissionable.campaign_rate
          expected_commission = ((expected_percentage*purchase.net_amount_cents)/100.0).floor

          expect(commission.amount_cents).to equal(expected_commission)
          expect(commission.percentage).to equal(expected_percentage)
        end

        it 'the FR commission should store the amount remaining' do
          purchase = FactoryGirl.create(:affiliate_campaign_purchase)

          affiliate_commission = Commission.affiliate_commissionable.last
          fr_commission = Commission.coupon_book_commissionable.last

          expected_percentage = 100 - affiliate_commission.percentage
          expected_commission = ((expected_percentage*purchase.net_amount_cents)/100.0).floor

          expect(fr_commission.amount_cents).to equal(expected_commission)
          expect(fr_commission.percentage).to equal(expected_percentage)
        end

      end
    end #End Affiliate Campaign page

    context 'Community Page' do
      context "Affiliate Campaign page" do
        it 'creates a FR commission' do
          expect{
            FactoryGirl.create(:affiliate_community_purchase)
          }.to change{ Commission.coupon_book_commissionable.count }.by(1)
        end

        it 'creates a Affiliate commission' do
          expect{
            FactoryGirl.create(:affiliate_community_purchase)
          }.to change{ Commission.affiliate_commissionable.count }.by(1)
        end

        it 'the Affiliate commission should store the right amount' do
          purchase = FactoryGirl.create(:affiliate_community_purchase)
          commission = Commission.affiliate_commissionable.last

          expected_percentage = commission.commissionable.community_rate
          expected_commission = ((expected_percentage*purchase.net_amount_cents)/100.0).floor

          expect(commission.amount_cents).to equal(expected_commission)
          expect(commission.percentage).to equal(expected_percentage)
        end

        it 'the FR commission should store the amount remaining' do
          purchase = FactoryGirl.create(:affiliate_community_purchase)

          affiliate_commission = Commission.affiliate_commissionable.last
          fr_commission = Commission.coupon_book_commissionable.last

          expected_percentage = 100 - affiliate_commission.percentage
          expected_commission = ((expected_percentage*purchase.net_amount_cents)/100.0).floor

          expect(fr_commission.amount_cents).to equal(expected_commission)
          expect(fr_commission.percentage).to equal(expected_percentage)
        end
      end # End Affiliate Campaign page

      context 'Affiliate Campaign page with MediaAffiliate' do
        it 'creates a FR commission' do
          expect{
            FactoryGirl.create(:affiliate_and_media_community_purchase)
          }.to change{ Commission.coupon_book_commissionable.count }.by(1)
        end

        it 'creates a Affiliate commission' do
          expect{
            FactoryGirl.create(:affiliate_and_media_community_purchase)
          }.to change{ Commission.affiliate_commissionable.count }.by(1)
        end

        it 'creates a MediaAffiliate commission' do
          expect{
            FactoryGirl.create(:affiliate_and_media_community_purchase)
          }.to change{ Commission.media_commissionable.count }.by(1)
        end

        it 'the MediaAffiliate commission should store the right amount' do
          purchase = FactoryGirl.create(:affiliate_and_media_community_purchase)
          commission = Commission.media_commissionable.last

          expected_percentage = commission.commissionable.commission_percentage
          expected_commission = ((expected_percentage*purchase.net_amount_cents)/100.0).floor

          expect(commission.amount_cents).to equal(expected_commission)
          expect(commission.percentage).to equal(expected_percentage)
        end

        it 'the Affiliate commission should store the right amount' do
          purchase = FactoryGirl.create(:affiliate_and_media_community_purchase)
          commission = Commission.affiliate_commissionable.last

          expected_percentage = commission.commissionable.community_rate
          expected_commission = ((expected_percentage*purchase.net_amount_cents)/100.0).floor

          expect(commission.amount_cents).to equal(expected_commission)
          expect(commission.percentage).to equal(expected_percentage)
        end

        it 'the FR commission should store the amount remaining' do
          purchase = FactoryGirl.create(:affiliate_and_media_community_purchase)

          affiliate_commission = Commission.affiliate_commissionable.last
          media_commission = Commission.media_commissionable.last
          fr_commission = Commission.coupon_book_commissionable.last

          expected_percentage = 100 - affiliate_commission.percentage - media_commission.percentage
          expected_commission = ((expected_percentage*purchase.net_amount_cents)/100.0).floor

          expect(fr_commission.amount_cents).to equal(expected_commission)
          expect(fr_commission.percentage).to equal(expected_percentage)
        end
      end # End Affiliate Campaign page with MediaAffiliate

    end #End Community Page

  end #End Commissions

end
