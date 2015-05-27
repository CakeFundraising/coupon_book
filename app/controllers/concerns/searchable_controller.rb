module SearchableController
  extend ActiveSupport::Concern

  def coupons_search
    facets = [:zip_code, :merchandise_categories]

    @search = Coupon.solr_search do
      fulltext params[:search]
      paginate page: params[:page], per_page: 20

      facets.each do |f|
        send(:facet, f)
        send(:with, f, params[f]) if params[f].present?
      end
    end

    @facets = facets
    @coupons = CouponDecorator.decorate_collection @search.results

    if params[:search].nil?
      render "searches/coupons"
    else
      render "searches/coupons", layout: false
    end
  end


end