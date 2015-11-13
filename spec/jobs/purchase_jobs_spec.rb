require 'rails_helper'

RSpec.describe ResqueSchedule::AfterPurchase, type: :model do
  describe '#perform' do
    let(:stripe_helper) { StripeMock.create_test_helper }
    before { StripeMock.start }
    after { StripeMock.stop }

    describe "#update_purchasable_raised!" do
      it 'should update the CouponBook raised attribute' do
        coupon_book = FactoryGirl.create(:coupon_book)
        purchase = FactoryGirl.create(:purchase, purchasable: coupon_book)

        expect{
          described_class.perform(purchase.id)
        }.to change{ coupon_book.reload.raised_cents }.by(purchase.amount_cents)
      end

      it 'should not touch the CouponBook Community object' do
        coupon_book = FactoryGirl.create(:coupon_book)
        community = FactoryGirl.create(:community, coupon_book: coupon_book)
        purchase = FactoryGirl.create(:purchase, purchasable: coupon_book)

        expect{
          described_class.perform(purchase.id)
        }.to_not change{ community.updated_at }
      end

      it 'should update the AffiliateCampaign raised attribute' do
        affiliate_campaign = FactoryGirl.create(:affiliate_campaign)
        purchase = FactoryGirl.create(:purchase, purchasable: affiliate_campaign)

        expect{
          described_class.perform(purchase.id)
        }.to change{ affiliate_campaign.reload.raised_cents }.by(purchase.amount_cents)
      end

      it 'should touch the AffiliateCampaign Community object' do
        affiliate_campaign = FactoryGirl.create(:affiliate_campaign)
        purchase = FactoryGirl.create(:purchase, purchasable: affiliate_campaign)

        expect{
          described_class.perform(purchase.id)
        }.to change{ affiliate_campaign.community.reload.updated_at }
      end
    end #End-update_purchasable_raised!

    describe "#create_vouchers!" do
      let!(:purchase) { FactoryGirl.create(:purchase, purchasable: FactoryGirl.create(:coupon_book_with_coupons)) }

      it 'should create vouchers if none present' do
        expect{
          described_class.perform(purchase.id)
        }.to change{ purchase.vouchers.count }
      end

      it 'should not create new vouchers if any already present' do
        described_class.perform(purchase.id)

        expect{
          described_class.perform(purchase.id)
        }.to_not change{ purchase.vouchers.count }
      end

      it 'should create one voucher per coupon' do
        coupon_book = purchase.purchasable
        described_class.perform(purchase.id)

        expect(coupon_book.coupons.count).to eql(coupon_book.vouchers.count)
      end
    end

  end
end
