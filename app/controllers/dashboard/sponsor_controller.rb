class Dashboard::SponsorController < ApplicationController
  def home
    @sponsor = current_merchant
  end

  def history
  end

  def coupons
    @coupons = current_merchant.coupons.decorate
  end

  def pr_boxes
    @pr_boxes = current_merchant.pr_boxes.decorate
  end
end