RSpec.shared_examples "a transferable object" do
  it { should have_many(:transfers).dependent(:destroy) }

  let!(:transferable) { FactoryGirl.create(described_class.name.underscore.to_sym) }
  let(:stripe_helper) { StripeMock.create_test_helper }
  before { StripeMock.start }
  after { StripeMock.stop }

  describe "#transfer!" do
    let(:amount_cents){ 5000 }
    
    before(:each) do
      balance_transaction = OpenStruct.new(amount: amount_cents, fee: stripe_fee_cents(amount_cents), currency: 'usd')
      allow(Stripe::BalanceTransaction).to receive(:retrieve).and_return(balance_transaction)
    end

    context "Stripe Marketplace Balance" do
      it "should create a transfer if there is available balance" do
        set_balance(100000)
        expect{ transferable.transfer!(amount_cents) }.to change{ Transfer.count }.by(1)
      end

      it "should not create a transfer if no available balance" do
        set_balance(3000)
        expect{ transferable.transfer!(amount_cents) }.to_not change{ Transfer.count }
      end
    end

    context 'Related Stripe account' do
      it "should not create a transfer if an Stripe account is not connected" do
        set_balance(100000)
        transferable.stripe_account.destroy
        transferable.reload

        expect{ transferable.transfer!(amount_cents) }.to_not change{ Transfer.count }
      end
    end

    context "Commissions" do
      before(:each) do
        create_list(:fr_media_purchase, 5, purchasable: transferable)
      end

      it "should flag all pending commissions as paid" do
        set_balance(100000)

        expect{ transferable.transfer!(amount_cents) }.to change{ transferable.commissions.pending.count }.from(5).to(0).and change{ transferable.commissions.paid.count }.from(0).to(5)
      end
    end
  end

  def set_balance(amount_cents)
    balance = OpenStruct.new(object: "balance", available: [OpenStruct.new({amount: amount_cents, currency: "usd"})], livemode: false, pending: [{amount: 55326715, currency: "usd"}])
    allow(Stripe::Balance).to receive(:retrieve).and_return(balance)
  end
end