module ResqueSchedule

  class AfterPurchase 
    extend Resque::Plugins::Retry
    @queue = :high

    @retry_limit = 3
    @retry_delay = 60

    def self.perform(purchase_id)
      purchase = Purchase.find purchase_id
      purchase.create_vouchers!
      VoucherMailer.coupon_book(purchase).deliver_now
    end
  end
  
end