module ResqueSchedule

  class CouponBookEnd 
    extend Resque::Plugins::Retry
    @queue = :high

    @retry_limit = 3
    @retry_delay = 60

    def self.perform
      CouponBook.to_end.each do |coupon_book|
        coupon_book.end
      end
    end
  end
  
  class CouponBookScreenshot
    extend Resque::Plugins::Retry
    @queue = :high

    @retry_limit = 3
    @retry_delay = 60

    def self.perform(coupon_book_id, url)
      CouponBook.find(coupon_book_id).update_screenshot(url)
    end
  end

end