class PrBoxesController < InheritedResources::Base
  before_action :set_collection, only: :create

  def new
    session[:redirect_to] = params[:redirect_to]
    @pr_box = PrBox.new
  end

  def create
    @pr_box = @collection.pr_boxes.build(permitted_params[:pr_box])
    @pr_box.origin_collection = @collection

    create! do |success, failure|
      success.html do
        redirect_to after_create_path, notice: 'Pr Box created successfully.'
        session.delete(:redirect_to)
      end
    end
  end

  private

  def set_collection
    owner = current_fundraiser || current_sponsor
    @collection = owner.collection
  end

  def after_create_path
    session[:redirect_to]
  end

  def permitted_params
    params.permit(pr_box:[
      :id, :headline, :story, :url, :flag,
      picture_attributes: [
        :id, :banner, :avatar, :qrcode, :avatar_caption,
        :avatar_crop_x, :avatar_crop_y, :avatar_crop_w, :avatar_crop_h,
        :banner_crop_x, :banner_crop_y, :banner_crop_w, :banner_crop_h,
        :qrcode_crop_x, :qrcode_crop_y, :qrcode_crop_w, :qrcode_crop_h
      ]
    ])
  end
end