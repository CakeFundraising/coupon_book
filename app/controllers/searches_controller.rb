class SearchesController < ApplicationController
  def search_coupons
    facets = [:merchandise_categories]

    @search = Coupon.solr_search(include: [:picture]) do
      fulltext params[:search]
      with :status, :launched
      with :universal, true
      order_by :created_at, :desc
      paginate page: params[:page], per_page: 21

      facets.each do |f|
        send(:facet, f)
        send(:with, f, params[f]) if params[f].present?
      end
    end

    @facets = facets
    @coupons = CouponDecorator.decorate_collection @search.results
    
    @collections_coupons = current_fundraiser.coupon_collection.coupons if current_fundraiser.present?

    if request.xhr?
      render "searches/coupons", layout: false
    else
      render "searches/coupons"
    end
  end
end