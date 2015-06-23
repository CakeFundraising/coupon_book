class VoucherMailer < ApplicationMailer
  def coupon_book(coupon_book_id, email, vouchers_ids)
    @coupon_book = find_coupon_book(coupon_book_id)

    pdf = CouponBookPdf.new(@coupon_book, vouchers_ids)
    attachments["#{@coupon_book}_book.pdf"] = {
      content: pdf.render,
      mime_type: 'application/pdf'
    }
    mail(to: email, subject: "Cake Coupon Book #{@coupon_book} Vouchers")
  end
end
