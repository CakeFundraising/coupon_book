class HomeController < ApplicationController
  before_action :go_to_registration, only: :index
  before_action :block_registered_user, only: :get_started

  def index
    #@purchase = Purchase.first.decorate
    # @book = @purchase.purchasable

    #render layout:'mailer'
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
