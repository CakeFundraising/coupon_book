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

  #Vouchers
  def vouchers
    @purchase = resource
    @book = resource.purchasable.decorate
    @fundraiser = @book.fundraiser
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

  def permitted_params
    params.permit(purchase: [:purchasable_type, :purchasable_id, :card_token, :amount_cents, :email])
  end

  def validate_token
    redirect_to root_path, alert:"You're not authorized to see this page." if params[:token].blank? or params[:token] != resource.token
  end
end