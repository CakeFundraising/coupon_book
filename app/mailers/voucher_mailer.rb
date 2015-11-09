class VoucherMailer < ApplicationMailer
  # def download_page(purchase)
  #   @purchase = purchase.decorate
  #   @campaign = @purchase.purchasable.decorate
  #   gift = purchase.gift

  #   if gift.nil?
  #     @name = @purchase.first_name
  #     mail(to: purchase.email, subject: "Download your deal vouchers from #{@campaign.owner_name}")
  #   else
  #     @name = gift.first_name
  #     mail(to: gift.email, cc: purchase.email, subject: "Download your deal vouchers from #{@campaign.owner_name}")
  #   end
  # end

  def send_vouchers(purchase)
    @purchase = purchase.decorate
    @campaign = @purchase.purchasable.decorate
    @vouchers = purchase.vouchers.decorate
    @gift = purchase.gift

    attachments["Vouchers.pdf"] = WickedPdf.new.pdf_from_string(
      render_to_string(
        pdf: "vouchers",
        template: 'purchases/pdf/main.pdf.slim',
        layout: "pdf.html.slim",
      ),{
        orientation: 'Landscape'
      }
    )

    if @gift.nil?
      @name = @purchase.first_name
      mail(to: purchase.email, subject: "Enjoy rewards from #{@campaign.owner_name}")
    else
      @name = @gift.first_name
      @purchaser_name = @purchase.full_name
      mail(to: @gift.email, cc: purchase.email, subject: "Enjoy this gift from #{@purchaser_name}")
    end
  end

  def send_free_voucher(purchase)
    @purchase = purchase
    @vouchers = purchase.vouchers.decorate

    attachments["Vouchers.pdf"] = WickedPdf.new.pdf_from_string(
      render_to_string(
        pdf: "vouchers",
        template: 'purchases/pdf/main.pdf.slim',
        layout: "pdf.html.slim",
      ),{
        orientation: 'Landscape'
      }
    )
      
    mail(to: purchase.email, subject: "Thank you from Baltimore Eats for Good!")
  end
end
