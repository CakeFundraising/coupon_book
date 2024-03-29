class PurchasesController < InheritedResources::Base
  before_action :validate_token, only: :vouchers
  skip_before_action :verify_authenticity_token, only: :create

  def create
    @purchase = Purchase.new(permitted_params[:purchase])

    create! do |success, failure|
      success.html do
        flash[:notice] = nil
        redirect_to after_purchase_path
      end
      failure.html do
        error_message = (@purchase.errors.messages.try(:[], :stripe) || @purchase.errors.messages).first
        redirect_to donate_coupon_book_path(@purchase.purchasable), alert: "There was an error with your payment: #{error_message}"
      end
    end

  end

  def succeeded
    @purchase = resource.decorate
    @purchasable = @purchase.purchasable
  end

  #Vouchers
  def vouchers
    @purchase = resource
    @campaign = resource.purchasable.decorate
    @vouchers = resource.vouchers.decorate

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "vouchers",   # Excluding ".pdf" extension.
               disposition: "inline",
               template: "purchases/pdf/main.pdf.slim",
               layout: "pdf.html.slim",
               orientation: 'Landscape',                  # default Portrait
               show_as_html: params[:debug].present?      # allow debugging based on url param
               # page_size:  'A4, Letter, ...',            # default A4
               # page_height:    960px,
               # page_width:     720px
 
      end
    end
  end

  protected

  def after_purchase_path
    if (mobile_device? || ipad?)
      succeeded_purchase_path(@purchase)
    else
      if @purchase.gift?
        polymorphic_path(@purchase.purchasable, purchased: 1, gift: 1, gifts_email: @purchase.gift.email, buyers_email: @purchase.email, name: @purchase.first_name)
      else
        polymorphic_path(@purchase.purchasable, purchased: 1, email: @purchase.email, name: @purchase.first_name)
      end
    end
  end

  def permitted_params
    params.permit(purchase: [
      :first_name, :last_name, :zip_code, :comment, :purchasable_type, 
      :purchasable_id, :card_token, :amount, :email, :hide_name,
      commissions_attributes: [:commissionable_type, :commissionable_id, :fcp],
      gift_attributes: [:first_name, :last_name, :email, :comment]
    ])
  end

  def validate_token
    redirect_to root_path, alert: "You're not authorized to see this page." if params[:token].blank? or params[:token] != resource.token
  end
end