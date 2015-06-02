class FundraisersController < ApplicationController
  def collection_coupons
    @collections_coupons = current_fundraiser.collection.coupons.latest
  end

  def collection_pr_boxes
    @collection_pr_boxes = current_fundraiser.collection.pr_boxes.latest
  end
end