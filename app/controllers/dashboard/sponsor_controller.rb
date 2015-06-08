class Dashboard::SponsorController < ApplicationController
  def home
  end

  def history
  end

  def coupons
    @coupons = current_sponsor.coupons.launched.decorate
  end

  def pr_boxes
    @pr_boxes = current_sponsor.pr_boxes.decorate
  end
end