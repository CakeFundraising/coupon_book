class DashboardController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    render "dashboard/home/#{current_user.roles.first}"
  end

  def account
    @user = current_user
  end

  def history
    
  end

  def withdraw
    
  end
end