class UsersController < ApplicationController
  def sign_in
    @user = User.new
  end

  def new_session
    User.new_session!(params[:user])
  end
end