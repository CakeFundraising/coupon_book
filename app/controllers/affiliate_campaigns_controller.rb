class AffiliateCampaignsController < InheritedResources::Base
  defaults resource_class: AffiliateCampaign.friendly
  load_and_authorize_resource

  include AffiliateCampaignTemplateController
  include AffiliatePageActions

  def index
    @campaigns = current_affiliate.affiliate_campaigns.not_past.latest.decorate
  end

  #Default actions
  def create
    @affiliate_campaign = current_affiliate.affiliate_campaigns.build(*resource_params)

    create! do |success, failure|
      success.html do
        update_screenshot(@affiliate_campaign)
        redirect_to join_affiliate_campaign_path(@affiliate_campaign)
      end
      failure.html do
        render action: :new
      end
    end
  end

  def update
    update! do |success, failure|
      success.html do
        update_screenshot(@affiliate_campaign)
        redirect_to controller: :affiliate_campaigns, action: params[:affiliate_campaign][:step], id: resource
      end
      failure.html do
        step_action = TEMPLATE_STEPS[TEMPLATE_STEPS.index(params[:affiliate_campaign][:step].to_sym)-1].to_s
        render 'affiliate_campaigns/template/' + step_action
      end
    end
  end

  def update_commission
    update! do |success, failure|
      success.html do
        redirect_to affiliates_coupon_book_path(@affiliate_campaign.coupon_book), notice: 'Commission updated.'
      end
      failure.html do
        redirect_to affiliates_coupon_book_path(@affiliate_campaign.coupon_book), alert: 'There was an error when trying to update the Commission.'
      end
    end
  end

  def destroy
    destroy! do |success, failure|
      success.html do
        redirect_to affiliate_campaigns_path, notice: 'Campaign was successfully destroyed.'
      end
    end
  end

  private

  def permitted_params
    params.permit(affiliate_campaign: [
      :first_name, :last_name, :phone, :email, :url, :organization_name, :story, :community_id,
      :use_stripe, :check_recipient_name, :community_rate, :campaign_rate,
      location_attributes: [:address, :city, :zip_code, :state_code, :country_code],
      avatar_picture_attributes: [
        :id, :uri, :caption, :avatar_crop_x, :avatar_crop_y, 
        :avatar_crop_w, :avatar_crop_h, :bypass_cloudinary_validation
      ]
    ])
  end

  def update_screenshot(affiliate_campaign)
    Resque.enqueue(ResqueSchedule::AffiliateCampaignScreenshot, affiliate_campaign.id, affiliate_campaign_url(affiliate_campaign)) unless Rails.env.test?
  end
end