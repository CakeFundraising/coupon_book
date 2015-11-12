module ResqueSchedule
  class CampaignEnd 
    extend Resque::Plugins::Retry
    @queue = :high

    @retry_limit = 3
    @retry_delay = 60

    def self.perform
      CouponBook.to_end.each do |campaign|
        campaign.end
      end
    end
  end

  class BookScreenshot
    extend Resque::Plugins::Retry
    @queue = :high

    @retry_limit = 3
    @retry_delay = 60

    def self.perform(book_id, url)
      CouponBook.find(book_id).update_screenshot(url)
    end
  end

  class AffiliateCampaignScreenshot
    extend Resque::Plugins::Retry
    @queue = :high

    @retry_limit = 3
    @retry_delay = 60

    def self.perform(campaign_id, url)
      AffiliateCampaign.find(campaign_id).update_screenshot(url)
    end
  end

  class CommunityScreenshot
    extend Resque::Plugins::Retry
    @queue = :high

    @retry_limit = 3
    @retry_delay = 60

    def self.perform(community_id, url)
      Community.find(community_id).update_screenshot(url)
    end
  end

  class NotifyLaunch
    extend Resque::Plugins::Retry
    @queue = :high

    @retry_limit = 3
    @retry_delay = 60

    def self.perform(book_id)
      CouponBook.find(book_id).notify_launch_consumers
    end
  end

end