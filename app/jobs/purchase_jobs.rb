module ResqueSchedule

  class AfterPurchase 
    extend Resque::Plugins::Retry
    @queue = :high

    @retry_limit = 3
    @retry_delay = 60

    def self.perform(purchase_id)
      purchase = Purchase.find purchase_id
      purchase.update_purchasable_raised!
      purchase.create_vouchers!

      VoucherMailer.send_vouchers(purchase).deliver_now if purchase.should_notify
    end
  end

  class ResendEmails
    extend Resque::Plugins::Retry
    @queue = :high

    @retry_limit = 3
    @retry_delay = 60

    def self.perform(purchase_id)
      purchase = Purchase.find purchase_id
      VoucherMailer.send_vouchers(purchase).deliver_now
    end
  end

  class SendFreeVoucher
    extend Resque::Plugins::Retry
    @queue = :high

    @retry_limit = 3
    @retry_delay = 60

    def self.perform(purchase_id)
      purchase = Purchase.find purchase_id
      purchase.create_vouchers!
      VoucherMailer.send_free_voucher(purchase).deliver_now
    end
  end
  
end