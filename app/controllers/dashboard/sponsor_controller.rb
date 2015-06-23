class Dashboard::SponsorController < ApplicationController
  def home
    @sponsor = current_sponsor
  end

  def history
  end

  def coupons
    @coupons = current_sponsor.coupons.launched.decorate
  end
end