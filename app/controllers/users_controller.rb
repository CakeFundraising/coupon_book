class UsersController < ApplicationController
  def sign_in
  end

  def new_session
    auth = Cake::Oauth::Session.new(params[:user]).authenticate!

    if auth[:granted]
      session[:access_token] = auth[:token]
      flash[:notice] = I18n.t('flash.auth.successful')
      redirect_to root_path
    else
      flash[:alert] = auth[:error]
      redirect_to sign_in_path
    end
  end

  def sign_out
    session.delete(:access_token)
    redirect_to root_path, notice: 'Signed Out successfully.'
  end
end