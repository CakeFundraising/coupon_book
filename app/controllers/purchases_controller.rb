class PurchasesController < InheritedResources::Base
  def create
    @purchase = Purchase.new(permitted_params[:purchase])

    create! do |success, failure|
      success.html do
        redirect_to polymorphic_path(@purchase.purchasable), notice: "Thanks for helping! We sent a book with all vouchers to your email address: #{@purchase.email}"
      end
      failure.html do
        redirect_to @purchase.purchasable, alert: "There was an error with your payment, please try again."
      end
    end

  end

  protected

  def permitted_params
    params.permit(purchase: [:purchasable_type, :purchasable_id, :card_token, :amount, :email])
  end
end