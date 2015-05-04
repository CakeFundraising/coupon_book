class CollectionsController < InheritedResources::Base

  def index
    @collection = current_fundraiser.coupon_collection || current_fundraiser.create_coupon_collection
  end

  def show
  end

  def edit
    @collection = current_fundraiser.coupon_collection || current_fundraiser.create_coupon_collection
    @collections_coupons = @collection.coupons.latest.decorate
  end

  def add_coupons
    @coupons = Coupon.all.decorate

    @collection = current_fundraiser.coupon_collection || current_fundraiser.create_coupon_collection

    @collections_coupons = @collection.coupons.latest.decorate

    @coupon = Coupon.new(collection_id: @collection.id)

    session[:return_to] ||= request.referer

    render 'collections/add_coupons'
  end
end