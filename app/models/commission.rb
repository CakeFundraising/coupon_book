class Commission < ActiveRecord::Base
  belongs_to :purchase
  belongs_to :owner, polymorphic: true

  has_one :purchasable, through: :purchase
  has_one :community, through: :purchasable

  monetize :amount_cents

  def self.create_from_purchase!(purchase)
    if purchase.purchasable.is_a?(AffiliateCampaign)
      community = purchase.purchasable.community
      amount_cents = ((community.commission_percentage*purchase.amount_cents)/100.0).round
      purchase.create_commission(percentage: community.commission_percentage, amount_cents: amount_cents)
    end
  end
end
