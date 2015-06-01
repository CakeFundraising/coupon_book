class CollectionsCouponsController < InheritedResources::Base
  
  respond_to :json

  def create
    @collections_coupon = collection.collections_coupons.build(permitted_params[:collections_coupon])

    create! do |success, failure|
      success.json do
        head :ok
      end
    end
  end
  
  def destroy
    @collections_coupon = CollectionsCoupon.find_by_coupon_id_and_collection_id(permitted_params[:collections_coupon][:coupon_id], collection.id)

    destroy! do |success, failure|
      success.json do
        head :ok
      end
    end
  end
  
  private

  def collection
    current_fundraiser.collection
  end

  def permitted_params
    params.permit(collections_coupon: [:coupon_id, :collection_id])
  end
end