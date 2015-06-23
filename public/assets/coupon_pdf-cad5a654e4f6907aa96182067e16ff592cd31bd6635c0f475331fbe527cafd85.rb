require 'open-uri'
require 'prawn/qrcode'

module CouponPdf
  def self.coupon_box(pdf, voucher)
    coupon = voucher.coupon.decorate

    pdf.print_qr_code(voucher.number, extent: 72)

    pdf.bounding_box([15, 450], width: 700, height: 220) do
      pdf.stroke_color 'CCCCCC'
      pdf.stroke_bounds


      pdf.define_grid(columns: 3, rows: 1, gutter: 0)

      pdf.grid(0,0).bounding_box do
        pdf.image avatar(coupon), width: 200, height: 133, position: 15, vposition: 15
      end

      pdf.grid(0,1).bounding_box  do
        pdf.move_down 15

        pdf.text coupon.trunc_title, size: 30
        
        pdf.move_down 10

        pdf.text coupon.trunc_description
      end

      pdf.grid(0,2).bounding_box  do
        pdf.image qrcode(coupon), width: 75, height: 75, position: 145, vposition: 15

        pdf.move_down 30

        pdf.text 'Promo Code', size: 18, align: :right
        pdf.text coupon.promo_code, size: 16, align: :right
      end

      #grid.show_all
    end
    
    pdf.move_down 30

    pdf.text "Expires: #{coupon.expires_at}", size: 20, align: :left

    unless coupon.multiple_locations.blank?
      pdf.text "Limitations", size: 20, align: :right
      pdf.text coupon.multiple_locations, size: 12, align: :right
    end

    pdf.move_down 30

    pdf.text 'The Fine Print', size: 20
    
    pdf.text 'Merchant Terms & Conditions', size: 14
    pdf.text coupon.custom_terms, size: 9
    
    pdf.text 'Universal Terms & Conditions', size: 14
    pdf.text I18n.t('application.terms_and_conditions.coupons'), size: 9
  end

  def self.avatar(coupon)
    return open(coupon.picture.avatar_path) if coupon.picture.object.avatar.present?
    "#{Rails.root}/app/assets/images/placeholder_avatar.png"
  end

  def self.qrcode(coupon)
    return open(coupon.picture.qrcode_path) if coupon.picture.object.qrcode.present?
    "#{Rails.root}/app/assets/images/placeholder_transparent.png"
  end
end