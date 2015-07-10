class VoucherMailer < ApplicationMailer
  def coupon_book(purchase)
    @purchase = purchase.decorate
    @coupon_book = @purchase.purchasable

    # pdf = CouponBookPdf.new(@coupon_book, vouchers_ids)
    # attachments["#{@coupon_book}_book.pdf"] = {
    #   content: pdf.render,
    #   mime_type: 'application/pdf'
    # }
    mail(to: @purchase.email, subject: "Enjoy rewards from #{@coupon_book}")
  end
end
