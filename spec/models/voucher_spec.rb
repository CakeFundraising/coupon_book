require 'rails_helper'

RSpec.describe Voucher, type: :model do
  describe "Model validatity" do
    it { should validate_presence_of(:expires_at) }
    it { should validate_presence_of(:categories_coupon_id) }
    it { should validate_presence_of(:purchase_id) }

    it { should belong_to(:categories_coupon) }
    it { should belong_to(:purchase) }
    it { should belong_to(:owner) }
  end

  describe "Methods" do
    describe "#set_number" do
      it 'should set a voucher number if blank' do
        voucher = FactoryGirl.build(:voucher, number: '')
        number = "#{voucher.coupon_book.id}#{voucher.purchase_id}#{voucher.coupon.id}"
        expect{ voucher.send(:set_number) }.to change{ voucher.number }.from('').to(number)
      end
      
      it 'should not set a voucher number if present' do
        voucher = FactoryGirl.build(:voucher)
        expect{ voucher.send(:set_number) }.to_not change{ voucher.number }
      end
    end

    describe 'redeem!' do
      context "Voucher Redeemed" do
        let!(:voucher){ FactoryGirl.create(:redeemed_voucher) }

        it 'should not redeem the voucher' do
          expect{ voucher.redeem!(nil) }.to_not change{ voucher.status }
        end

        it 'should return not allowed' do
          result = voucher.redeem!(nil)
          expect(result[:allowed]).to eql(false)
        end
      end

      context "Expired Redeemed" do
        let!(:voucher){ FactoryGirl.create(:expired_voucher) }

        it 'should not redeem the voucher' do
          expect{ voucher.redeem!(nil) }.to_not change{ voucher.status }
        end

        it 'should return not allowed' do
          result = voucher.redeem!(nil)
          expect(result[:allowed]).to eql(false)
        end
      end

      context "Valid Voucher" do
        let!(:voucher){ FactoryGirl.create(:voucher) }

        it 'should redeem the voucher' do
          expect{ voucher.redeem!(nil) }.to change{ voucher.status }.from('pending').to('redeemed')
        end

        it 'should return allowed' do
          result = voucher.redeem!(nil)
          expect(result[:allowed]).to eql(true)
        end
      end

    end

    describe "#validate_status" do
      context "Voucher Redeemed" do
        let!(:voucher){ FactoryGirl.create(:redeemed_voucher) }

        it 'should return not allowed' do
          validation = voucher.validate_status
          expect(validation[:allowed]).to eql(false)
        end

        it 'should show an error message' do
          validation = voucher.validate_status
          expect(validation[:message]).to_not be_empty
        end
      end

      context "Expired voucher" do
        let!(:voucher){ FactoryGirl.create(:expired_voucher) }

        it 'should return not allowed' do
          validation = voucher.validate_status
          expect(validation[:allowed]).to eql(false)
        end

        it 'should show an error message' do
          validation = voucher.validate_status
          expect(validation[:message]).to_not be_empty
        end
      end

      context 'Valid voucher' do
        let!(:voucher){ FactoryGirl.create(:voucher) }

        it 'should return allowed' do
          validation = voucher.validate_status
          expect(validation[:allowed]).to eql(true)
        end

        it 'should show a notice message' do
          validation = voucher.validate_status
          expect(validation[:message]).to_not be_empty
        end
      end
    end

  end       
end
