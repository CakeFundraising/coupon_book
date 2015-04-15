class UsersController < ApplicationController
  def sign_in
  end

  def new_session
    session[:access_token] = Cake::Oauth::Session.new(params[:user]).access_token

    if session[:access_token].present?
      User.fetch_and_create!(session[:access_token])
      flash[:notice] = 'Sign in successful'
    else
      flash[:alert] = 'There was an error when signing in, please try again'
    end

    redirect_to root_path
  end
end