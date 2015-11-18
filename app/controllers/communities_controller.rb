class CommunitiesController < InheritedResources::Base
  defaults resource_class: Community.friendly

  def show
    @community = resource.decorate
    @coupon_book = @community.coupon_book.decorate
    @categories = @coupon_book.categories.decorate

    @affiliate_campaigns = @community.affiliate_campaigns.order_by_raised.decorate

    if mobile_device?
      render 'communities/show/mobile/main', layout: 'layouts/books/mobile'
    else
      @purchases = PurchaseDecorator.decorate_collection @community.purchases.first(5)
      render 'communities/show/desktop/main', layout: 'layouts/books/desktop'
    end
  end

  def update
    update! do |success, failure|
      failure.html do
        redirect_to request.referrer, alert: @community.errors.messages.values.join('\n')
      end
      success.html do
        update_screenshot(@community)
        redirect_to request.referrer, notice: 'Community settings successfully updated.'
      end
    end
  end

  private
  
  def permitted_params
    params.permit(community: [:slug, :affiliate_commission_percentage, :media_commission_percentage])
  end

  def update_screenshot(community)
    Resque.enqueue(ResqueSchedule::CommunityScreenshot, community.id, community_url(community)) unless Rails.env.test?
  end
end