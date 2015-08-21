class UsersController < ApplicationController
  def index
  end

  def roles
    role = params[:role]

    if role == 'cakester'
      current_user.set_cakester!
      redirect_to new_cakester_path
    elsif role == 'merchant'
      current_user.set_merchant!
      redirect_to new_merchant_path
    elsif role == 'affiliate'
      current_user.set_affiliate!
      redirect_to new_affiliate_path
    else
      redirect_to home_get_started_path, alert:"That role does not exist. Sorry."
    end
  end
end