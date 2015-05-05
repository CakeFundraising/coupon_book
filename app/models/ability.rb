class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :update, :destroy, to: :crud
    user ||= User.new

    if user.fundraiser?
      #CouponBook
      can :create, CouponBook
      can [:launch, :save_for_launch, :toggle_visibility], CouponBook, fundraiser_id: user.fundraiser.id
      can [:update, :destroy] + CouponBooksController::TEMPLATE_STEPS, CouponBook, fundraiser_id: user.fundraiser.id
    end 
  end
end
