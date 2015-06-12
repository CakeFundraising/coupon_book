include CouponPdf

class CouponBookPdf < Pdf
  def initialize(book, vouchers_ids)
    @document = Prawn::Document.new(page_layout: :landscape, page_size: "A4")
    @book = book
    @vouchers = Voucher.find(vouchers_ids)
    header
    body
  end

  private

  def body
    font "#{Rails.root}/app/assets/fonts/museosans-300-webfont.ttf"
    @vouchers.each_with_index do |voucher, index|
      start_new_page unless index.zero?
      CouponPdf.coupon_box(self, voucher)
    end
  end

end