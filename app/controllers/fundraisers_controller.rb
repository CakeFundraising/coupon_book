class FundraisersController < InheritedResources::Base
  include AccountController

  def collection_coupons
    book_coupons = CouponBook.find(params[:cb_id]).coupons
    @collection_coupons = current_fundraiser.collection.coupons.latest

    @collection_coupons.each do |coupon|
      coupon.disabled = book_coupons.include? coupon
    end
  end

  def collection_pr_boxes
    book_pr_boxes = CouponBook.find(params[:cb_id]).pr_boxes
    @collection_pr_boxes = current_fundraiser.collection.pr_boxes.latest

    @collection_pr_boxes.each do |pr_box|
      pr_box.disabled = book_pr_boxes.include? pr_box
    end
  end

  protected

  def permitted_params
    params.permit(fundraiser: [
      :first_name, :last_name, :organization_name, :email, :phone, :tax_exempt, :url,
      location_attributes: [:address, :city, :zip_code, :state_code, :country_code],
      avatar_picture_attributes: [
        :id, :uri, :caption, :avatar_crop_x, :avatar_crop_y, :avatar_crop_w, :avatar_crop_h, :bypass_cloudinary_validation
      ]
    ])
  end
end