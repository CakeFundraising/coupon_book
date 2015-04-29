class FundraisersController < ApplicationController
  def collection_coupons
    @collection = current_fundraiser.coupon_collection || current_fundraiser.create_coupon_collection
    @collections_coupons = @collection.coupons.latest
  end
end