class Dashboard::SponsorController < ApplicationController
  def home
  end

  def history
  end

  def coupons
    @coupons = current_sponsor.coupons.decorate
  end
end