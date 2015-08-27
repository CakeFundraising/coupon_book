class DashboardController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    render "dashboard/home/#{current_user.roles.first}"
  end

  def account
    @user = current_user
  end

  def history
    render "dashboard/history/#{current_user.roles.first}"
  end

  def withdraw
    @stripe_account = current_user.try(:stripe_account)
    render "dashboard/withdraw/#{current_user.roles.first}"
  end
end