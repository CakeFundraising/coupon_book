module Consumerable
  extend ActiveSupport::Concern

  included do
    has_many :consumers, as: :origin
  end

  def notify_launch_consumers
    self.consumers.each do |consumer|
      CampaignMailer.campaign_launched(self.id, consumer.id).deliver_now
    end
  end
end