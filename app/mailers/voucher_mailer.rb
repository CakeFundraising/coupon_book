class VoucherMailer < ApplicationMailer
  def download_page(purchase)
    @purchase = purchase.decorate
    @book = @purchase.purchasable

    mail(to: purchase.email, subject: "Download your deal vouchers from #{@book.fr_name}")
  end

  def send_vouchers(purchase)
    @purchase = purchase.decorate
    @book = @purchase.purchasable.decorate
    @fundraiser = @book.fundraiser
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
      
    mail(to: purchase.email, subject: "Enjoy rewards from #{@book.fr_name}")
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
