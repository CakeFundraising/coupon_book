class DashboardController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    p current_user
    render "dashboard/home/#{current_user.roles.first}"
  end

  def account
    
  end

  def history
    
  end

  def withdraw
    
  end
end