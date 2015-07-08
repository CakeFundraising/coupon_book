class FundraisersController < ApplicationController
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
end