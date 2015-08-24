class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :update, :destroy, to: :crud
    user ||= User.new

    if user.fundraiser?
      #CouponBook
      can :create, CouponBook
      can [:update, :destroy, :launch, :save_for_launch, :toggle_visibility, :categories, :save_organize] + CouponBooksController::TEMPLATE_STEPS, CouponBook, fundraiser_id: user.id

      #Coupon
      can :create, Coupon
      can [:update, :destroy, :launch, :universal_toggle] + CouponsController::TEMPLATE_STEPS, Coupon, owner: user
    end

    if user.merchant?
      can :create, Coupon
      can [:update, :destroy, :launch, :universal_toggle] + CouponsController::TEMPLATE_STEPS, Coupon, owner: user
    end

    can :read, :all

    can [:start_discount, :start_pr_box, :donate, :checkout], CouponBook
    can :click, Coupon
  end
end
