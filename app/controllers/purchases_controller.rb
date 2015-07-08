class PurchasesController < InheritedResources::Base
  before_action :validate_token, only: :vouchers

  def create
    @purchase = Purchase.new(permitted_params[:purchase])

    create! do |success, failure|
      success.html do
        redirect_to polymorphic_path(@purchase.purchasable, purchased: 1, email: @purchase.email)
      end
      failure.html do
        redirect_to @purchase.purchasable, alert: "There was an error with your payment, please try again."
      end
    end

  end

  def vouchers
    @book = resource.purchasable.decorate
    @coupons = @book.coupons.decorate
  end

  protected

  def permitted_params
    params.permit(purchase: [:purchasable_type, :purchasable_id, :card_token, :amount_cents, :email])
  end

  def validate_token
    redirect_to root_path, alert:"You're not authorized to see this page." if params[:token].blank? or params[:token] != resource.token
  end
end