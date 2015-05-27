include CouponPdf

class CouponBookPdf < Pdf
  def initialize(book)
    @document = Prawn::Document.new(page_layout: :landscape, page_size: "A4")
    @book = book
    @coupons = @book.coupons.decorate
    header
    body
  end

  private

  def body
    font "#{Rails.root}/app/assets/fonts/museosans-300-webfont.ttf"
    @coupons.each_with_index do |coupon, index|
      start_new_page unless index.zero?
      CouponPdf.coupon_box(self, coupon)
    end
  end

end