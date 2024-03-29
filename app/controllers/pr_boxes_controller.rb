class PrBoxesController < InheritedResources::Base
  before_action :set_collection, only: :create

  def index
    @pr_boxes = current_merchant.pr_boxes.page(params[:page]).per(20).decorate
  end

  def create
    @pr_box = PrBox.new(permitted_params[:pr_box])
    @pr_box.origin_collection = @collection

    create! do |success, failure|
      success.html do
        add_pr_box_to_collection(@pr_box)
        redirect_to after_create_path, notice: 'Pr Box created successfully.'
      end
    end
  end

  def update
    update! do |success, failure|
      success.html do
        redirect_to after_create_path, notice: 'Pr Box updated successfully.'
      end
    end
  end

  private

  def set_collection
    owner = current_fundraiser || current_merchant
    @collection = owner.collection
  end

  def after_create_path
    current_fundraiser.present? ? organize_coupon_book_path(params[:pr_box][:coupon_book_id]) : pr_boxes_path
  end

  def add_pr_box_to_collection(pr_box)
    # Add PR Box to FR collection when SP's PR Box
    CollectionPrBox.create(collection_id: params[:pr_box][:fr_collection_id], pr_box_id: pr_box.id) if params[:pr_box][:fr_collection_id].present?
  end

  def permitted_params
    params.permit(pr_box:[
      :id, :title, :description, :url, :flag, :universal, :sponsor_name,
      picture_attributes: [
        :id, :banner, :avatar, :qrcode, :avatar_caption,
        :avatar_crop_x, :avatar_crop_y, :avatar_crop_w, :avatar_crop_h,
        :banner_crop_x, :banner_crop_y, :banner_crop_w, :banner_crop_h,
        :qrcode_crop_x, :qrcode_crop_y, :qrcode_crop_w, :qrcode_crop_h
      ]
    ])
  end
end