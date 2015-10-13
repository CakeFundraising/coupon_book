class MediaAffiliateCampaignsController < InheritedResources::Base
  load_and_authorize_resource

  include MediaAffiliateCampaignTemplateController

  def index
    @campaigns = current_media_affiliate.media_affiliate_campaigns.latest.decorate
  end

  #Default actions
  def create
    @media_affiliate_campaign = current_media_affiliate.media_affiliate_campaigns.build(*resource_params)

    create! do |success, failure|
      success.html do
        #update_screenshot(@media_affiliate_campaign)
        redirect_to get_paid_media_affiliate_campaign_path(@media_affiliate_campaign)
      end
      failure.html do
        render action: :new
      end
    end
  end

  def update
    update! do |success, failure|
      success.html do
        #update_screenshot(@media_affiliate_campaign)
        redirect_to controller: :media_affiliate_campaigns, action: params[:media_affiliate_campaign][:step], id: resource
      end
      failure.html do
        step_action = TEMPLATE_STEPS[TEMPLATE_STEPS.index(params[:media_affiliate_campaign][:step].to_sym)-1].to_s
        render 'media_affiliate_campaigns/template/' + step_action
      end
    end
  end

  def update_commission
    update! do |success, failure|
      success.html do
        redirect_to media_affiliates_coupon_book_path(@media_affiliate_campaign.coupon_book), notice: 'Commission updated.'
      end
      failure.html do
        redirect_to media_affiliates_coupon_book_path(@media_affiliate_campaign.coupon_book), alert: 'There was an error when trying to update the Commission.'
      end
    end
  end

  def destroy
    destroy! do |success, failure|
      success.html do
        redirect_to media_affiliate_campaigns_path, notice: 'Campaign was successfully destroyed.'
      end
    end
  end

  private

  def permitted_params
    params.permit(media_affiliate_campaign: [
      :first_name, :last_name, :phone, :email, :url, :organization_name, :story, :community_id,
      :use_stripe, :recipient_name, :commission_percentage,
      location_attributes: [:address, :city, :zip_code, :state_code, :country_code],
      avatar_picture_attributes: [
        :id, :uri, :caption, :avatar_crop_x, :avatar_crop_y, 
        :avatar_crop_w, :avatar_crop_h, :bypass_cloudinary_validation
      ]
    ])
  end
end