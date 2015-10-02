class CommunitiesController < InheritedResources::Base
  defaults resource_class: Community.friendly

  def show
    @community = resource.decorate
    @coupon_book = @community.coupon_book.decorate
    @categories = @coupon_book.categories.decorate
    @first_category = @categories.first
    @discounts = @first_category.items.object.preloaded.decorate if @first_category.present?
    @purchases = PurchaseDecorator.decorate_collection @community.purchases.first(5)

    @affiliate_campaigns = @community.affiliate_campaigns.decorate

    render 'communities/show/main', layout: 'layouts/books/desktop'
  end

  def update
    update! do |success, failure|
      failure.html do
        redirect_to affiliates_coupon_book_path(@community.coupon_book), alert: @community.errors.messages.values.join('\n')
      end
      success.html do
        update_screenshot(@community)
        redirect_to affiliates_coupon_book_path(@community.coupon_book), notice: 'Community settings successfully updated.'
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