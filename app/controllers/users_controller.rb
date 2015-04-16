class UsersController < ApplicationController
  def sign_in
  end

  def new_session
    token = Cake::Oauth::Session.new(params[:user]).access_token

    if token.present?
      session[:access_token] = token
      flash[:notice] = 'Signed in successfully.'
    else
      flash[:alert] = 'There was an error when signing in, please try again'
    end

    redirect_to root_path
  end

  def sign_out
    session.delete(:access_token)
    redirect_to root_path, notice: 'Signed Out successfully.'
  end
end