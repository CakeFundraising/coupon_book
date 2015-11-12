module Consumerable
  extend ActiveSupport::Concern

  included do
    has_many :consumers, as: :origin
  end

  def notify_launch_consumers
    CampaignMailer.campaign_launched(self.id).deliver_now
  end
end