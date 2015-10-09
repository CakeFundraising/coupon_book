class DashboardController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    @user = current_user.decorate
    render "dashboard/home/#{current_user.roles.first}"
  end

  def account
    @user = current_user
  end

  def history
    render "dashboard/history/#{current_user.roles.first}"
  end

  #Get Paid
  def transfers
    @campaigns = current_user.campaigns.decorate
  end

  def stripe
    @stripe_account = current_user.try(:stripe_account)
  end
end