class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :update, :destroy, to: :crud
    user ||= User.new

    if user.fundraiser?
      #CouponBook
      can :create, CouponBook
      can [:update, :destroy, :launch, :save_for_launch, :toggle_visibility, :categories, :save_organize, :update_affiliate_campaign_rate] + CouponBooksController::TEMPLATE_STEPS, CouponBook, fundraiser_id: user.id

      #Coupon
      can :create, Coupon
      can [:update, :destroy, :launch, :universal_toggle] + CouponsController::TEMPLATE_STEPS, Coupon, owner: user

      can :update_commission, AffiliateCampaign, fundraiser: user
      can :update_commission, MediaAffiliateCampaign, fundraiser: user
    end

    if user.merchant?
      can :create, Coupon
      can [:update, :destroy, :launch, :universal_toggle] + CouponsController::TEMPLATE_STEPS, Coupon, owner: user
    end

    if user.affiliate?
      can :create, AffiliateCampaign
      can [:update, :destroy, :book_preview] + AffiliateCampaignsController::TEMPLATE_STEPS, AffiliateCampaign, affiliate_id: user.id
    end

    if user.media_affiliate?
      can :create, MediaAffiliateCampaign
      can [:update, :destroy, :book_preview] + MediaAffiliateCampaignsController::TEMPLATE_STEPS, MediaAffiliateCampaign, media_affiliate_id: user.id
    end

    can :read, :all

    can [:start_discount, :start_pr_box, :donate, :checkout], CouponBook
    can [:donate, :checkout], AffiliateCampaign
    can :click, Coupon
  end
end
