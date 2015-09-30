class Commission < ActiveRecord::Base
  belongs_to :purchase
  belongs_to :owner, polymorphic: true

  #has_one :purchasable, through: :purchase
  #has_one :community, through: :purchasable

  delegate :purchasable, :community, to: :purchase

  monetize :amount_cents

  before_save :set_percentage_and_amount, unless: :fr_owner?

  def fr_owner?
    owner.is_a?(Fundraiser)
  end

  def affiliate_owner?
    owner.is_a?(Affiliate)
  end

  def media_owner?
    owner.is_a?(MediaAffiliate)
  end

  protected

  def set_percentage_and_amount
    self.percentage = affiliate_owner? ? community.affiliate_commission_percentage : community.media_commission_percentage
    self.amount_cents = ((self.percentage*purchase.amount_cents)/100.0).round
  end

end