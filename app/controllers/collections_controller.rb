class CollectionsController < InheritedResources::Base

  def index
    @collection = current_fundraiser.coupon_collection || current_fundraiser.create_coupon_collection
  end

  def show
  end

  def edit
  end

  def add_coupon
    @coupon = Coupon.new(collection_id: @collection)
    session[:return_to] ||= request.referer
  end
end