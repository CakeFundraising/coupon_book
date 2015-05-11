class CollectionsController < InheritedResources::Base

  def index
    @collection = current_fundraiser.coupon_collection || current_fundraiser.create_coupon_collection
  end

  def show
  end

  def edit
    @collection = Collection.first_or_create!
    # @collection = current_fundraiser.coupon_collection || current_fundraiser.create_coupon_collection
    @collections_coupons = @collection.coupons.latest.decorate
  end

  def add_coupons
    @coupons = CouponDecorator.decorate_collection Coupon.all.page(params[:page])

    @collection = Collection.first_or_create!
    # @collection = current_fundraiser.coupon_collection || current_fundraiser.create_coupon_collection

    @collections_coupons = @collection.coupons.latest.decorate

    @coupon = Coupon.new(collection_id: @collection.id)

    session[:return_to] ||= request.referer

    render 'collections/add_coupons'
  end
end