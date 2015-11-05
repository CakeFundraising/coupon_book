RSpec.shared_examples "a transferable object" do
  it { should have_many(:transfers).dependent(:destroy) }

  describe "#transfer!" do
    let!(:transferable) { FactoryGirl.create(described_class.name.underscore.to_sym) } 
    let(:amount_cents){ 5000 }

    it "should create a transfer if there is available balance" do
      stripe_balance = {object: "balance", available: [{amount: 100000, currency: "usd"}],livemode: false, pending: [{amount: 55326715, currency: "usd"}]}
      stub_request(:get, "https://api.stripe.com/v1/balance").to_return(status: 200, body: stripe_balance.to_json, headers: {})

      expect{ transferable.transfer!(amount_cents) }.to change{ Transfer.count }.by(1)
    end
  end
end