class CommunitiesController < InheritedResources::Base
  defaults resource_class: Community.friendly

  def show
    @community = resource.decorate
    @coupon_book = @community.coupon_book.decorate
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