module ResqueSchedule
  class BookScreenshot
    extend Resque::Plugins::Retry
    @queue = :high

    @retry_limit = 3
    @retry_delay = 60

    def self.perform(book_id, url)
      CouponBook.find(book_id).update_screenshot(url)
    end
  end
end