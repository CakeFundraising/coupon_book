module ResqueSchedule

  class AfterPurchase 
    extend Resque::Plugins::Retry
    @queue = :high

    @retry_limit = 3
    @retry_delay = 60

    def self.perform(purchase_id)
      purchase = Purchase.find purchase_id
      vouchers_ids = purchase.purchasable.create_vouchers(purchase_id)
      VoucherMailer.coupon_book(purchase.purchasable.id, purchase.email, vouchers_ids).deliver_now
    end
  end
  
end