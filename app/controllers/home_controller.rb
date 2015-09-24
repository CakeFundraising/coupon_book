class HomeController < ApplicationController
  before_action :block_registered_user, only: :get_started
  before_action :go_to_registration, only: :index

  def index
    @campaigns = CouponBook.popular.decorate
  end

  def get_started
  end

  protected

  def block_registered_user
    redirect_to root_path if current_user.nil? or current_user.registered
  end

  def go_to_registration
    unless current_user.nil? or current_user.registered
      redirect_to home_get_started_path, notice: 'Please complete your registration in Eats For Good!'
    end
  end
end
