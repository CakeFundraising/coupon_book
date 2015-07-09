class Dashboard::SponsorController < ApplicationController
  def home
    @sponsor = current_sponsor
  end

  def history
  end

  def coupons
    @coupons = current_sponsor.coupons.decorate
  end

  def pr_boxes
    @pr_boxes = current_sponsor.pr_boxes.decorate
  end
end