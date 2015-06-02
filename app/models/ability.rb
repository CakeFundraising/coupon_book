class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :update, :destroy, to: :crud
    user ||= User.new

    if user.fundraiser?
      #CouponBook
      can :create, CouponBook
      can [:update, :destroy, :launch, :save_for_launch, :toggle_visibility, :categories] + CouponBooksController::TEMPLATE_STEPS, CouponBook, fundraiser_id: user.fundraiser.id

      #Coupon
      can :create, Coupon
      can [:update, :destroy, :launch, :universal_toggle] + CouponsController::TEMPLATE_STEPS, Coupon, owner: user.fundraiser
    end

    if user.sponsor?
      can :create, Coupon
      can [:update, :destroy, :launch, :universal_toggle] + CouponsController::TEMPLATE_STEPS, Coupon, owner: user.sponsor
    end

    can :read, :all
    can [:start_discount, :start_pr_box], CouponBook
  end
end
