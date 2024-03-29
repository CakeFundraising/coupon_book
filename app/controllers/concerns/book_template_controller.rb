module BookTemplateController
  extend ActiveSupport::Concern
  include Referrer

  included do
    before_action :save_referrer, only: :launching, unless: ->{ current_fundraiser.stripe_account? } 

    TEMPLATE_STEPS = [
      :basics,
      :story,
      :merchants,
      :organize,
      :affiliates,
      :media_affiliates,
      :launching,
      :share
    ]
  end

  #Template steps
  def basics
    @coupon_book = resource.decorate
    render 'coupon_books/template/basics'
  end

  def story
    @coupon_book = resource
    render 'coupon_books/template/story'
  end

  def merchants
    render 'coupon_books/template/merchants'
  end

  #Build coupon book
  def organize
    @coupon_book = resource
    @coupons = current_fundraiser.collection.coupons.decorate
    @pr_boxes = current_fundraiser.collection.pr_boxes.decorate
    render 'coupon_books/template/organize'
  end

  def save_organize
    processed_params = resource.process_categories_params(params[:categories])
    puts 
    p processed_params
    puts 
    saved = resource.update(categories_permitted_params(processed_params))
    puts
    p resource.errors.messages
    puts
    render text: saved
  end

  def categories
    @categories = resource.categories
    render 'coupon_books/show/categories'
  end

  def affiliates
    @coupon_book = resource.decorate
    @community = @coupon_book.community
    @affiliate_campaigns = @coupon_book.affiliate_campaigns.decorate
    render 'coupon_books/template/affiliates'
  end

  def update_affiliate_campaign_rate
    update! do |success, failure|
      success.html do
        redirect_to affiliates_coupon_book_path(resource), notice: 'Affiliate rate updated.'
      end
      failure.html do
        redirect_to affiliates_coupon_book_path(resource), alert: 'There was an error.'
      end
    end
  end

  def media_affiliates
    @coupon_book = resource.decorate
    @community = @coupon_book.community
    @media_affiliate_campaigns = @coupon_book.media_affiliate_campaigns.decorate
    render 'coupon_books/template/media_affiliates'
  end

  def launching
    @coupon_book = resource.decorate
    render 'coupon_books/template/launching'
  end

  def share
    @coupon_book = resource.decorate
    render 'coupon_books/template/share'
  end

  private

  def categories_permitted_params(cat_params)
    cat_params = ActionController::Parameters.new(cat_params)
    cat_params.permit(categories_attributes: [
      :id, :position, categories_coupons_attributes: [:id, :position, :coupon_id, :category_id, :_destroy]
    ])
  end
end