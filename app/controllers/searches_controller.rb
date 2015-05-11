class SearchesController < ApplicationController
  def search_coupons
    # facets = [:zip_code, :merchandise_categories]

    @search = Coupon.solr_search(include: [:picture]) do
      fulltext params[:search]
      # with :status, :accepted
      order_by :created_at, :desc
      paginate page: params[:page], per_page: 21

      # facets.each do |f|
      #   send(:facet, f)
      #   send(:with, f, params[f]) if params[f].present?
      # end
    end

    # @facets = facets
    # p @coupons

    @collection = Collection.first

    @collections_coupons = @collection.coupons

    @coupons = CouponDecorator.decorate_collection @search.results

    if request.xhr?
      render "searches/coupons", layout: false
    else
      render "searches/coupons"
    end
  end
end