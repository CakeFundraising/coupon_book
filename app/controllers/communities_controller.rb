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
      success.html do
        redirect_to affiliates_coupon_book_path(@community.coupon_book), notice: 'Community settings successfully updated.'
      end
    end
  end

  private
  
  def permitted_params
    params.permit(community: [:slug, :commission_percentage])
  end
end