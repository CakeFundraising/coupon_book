class UsersController < ApplicationController
  def index
  end

  def roles
    role = params[:role]

    if role == 'fundraiser'
      current_user.set_fundraiser!
      redirect_to new_fundraiser_path
    elsif role == 'merchant'
      current_user.set_merchant!
      redirect_to new_merchant_path
    elsif role == 'affiliate'
      current_user.set_affiliate!
      redirect_to new_affiliate_path
    elsif role == 'media_affiliate'
      current_user.set_media_affiliate!
      redirect_to new_media_affiliate_path
    else
      redirect_to home_get_started_path, alert:"That role does not exist. Sorry."
    end
  end
end