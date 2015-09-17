class CommunitiesController < InheritedResources::Base
  def show
    @community = resource.decorate
    @coupon_book = @community.coupon_book.decorate
  end
end