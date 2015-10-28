class VoucherMailer < ApplicationMailer
  def download_page(purchase)
    @purchase = purchase.decorate
    @campaign = @purchase.purchasable.decorate

    mail(to: purchase.email, subject: "Download your deal vouchers from #{@campaign.owner_name}")
  end

  def send_vouchers(purchase)
    @purchase = purchase.decorate
    @campaign = @purchase.purchasable.decorate
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
      
    mail(to: purchase.email, subject: "Enjoy rewards from #{@campaign.owner_name}")
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
