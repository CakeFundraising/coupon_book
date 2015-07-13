class CouponBooksController < InheritedResources::Base
  include CakeHelper
  load_and_authorize_resource
  before_action :redirect_to_coupon_template, only: :start_discount
  before_action :redirect_to_pr_box_template, only: :start_pr_box
  before_action :block_fr, only: [:start_discount, :start_pr_box]
  before_action :redirect_to_billing, only: :launch

  TEMPLATE_STEPS = [
    :basic_info,
    :tell_your_story,
    :coupons,
    :request_coupons,
    :launch_and_share
  ]

  def index
    @coupon_books = current_fundraiser.coupon_books.latest.decorate
  end

  def show
    @coupon_book = resource.decorate
    @header_banner = I18n.t('banners.coupon_book.header', fr: (@coupon_book.organization_name || @coupon_book.fundraiser), price: @coupon_book.price, no_discount: @coupon_book.no_discount_price).html_safe
    @categories = @coupon_book.categories.with_items.decorate
  end

  #Template steps
  def basic_info
    @coupon_book = resource.decorate
    render 'coupon_books/template/basic_info'
  end

  def tell_your_story
    @coupon_book = resource
    render 'coupon_books/template/tell_your_story'
  end

  #Build coupon book
  def coupons
    @coupon_book = resource
    render 'coupon_books/template/coupons'
  end

  def save_organize
    processed_params = resource.process_categories_params(params[:categories])
    puts 
    p processed_params
    puts 
    saved = resource.update(categories_permitted_params(processed_params))
    p resource.errors.messages
    render text: saved
  end

  def categories
    @categories = resource.categories
    render 'coupon_books/show/categories'
  end

  def request_coupons
    @coupon_book = resource.decorate
    render 'coupon_books/template/request_coupons'
  end

  #Launch 
  def launch_and_share
    @coupon_book = resource.decorate
    render 'coupon_books/template/launch_and_share'
  end

  #Default actions
  def create
    @coupon_book = current_fundraiser.coupon_books.build(*resource_params)

    create! do |success, failure|
      success.html do
        #update_screenshot(@coupon_book)
        redirect_to tell_your_story_coupon_book_path(@coupon_book)
      end
      failure.html do
        render action: :new
      end
    end
  end

  def update
    update! do |success, failure|
      success.html do
        #update_screenshot(@coupon_book)
        redirect_to controller: :coupon_books, action: params[:coupon_book][:step], id: resource
      end
      failure.html do
        step_action = TEMPLATE_STEPS[TEMPLATE_STEPS.index(params[:coupon_book][:step].to_sym)-1].to_s
        render 'coupon_books/template/' + step_action
      end
    end
  end

  def destroy
    destroy! do |success, failure|
      success.html do
        redirect_to coupon_books_path, notice: 'Coupon book was successfully destroyed.'
      end
    end
  end

  #Special Actions
  def save_for_launch
    resource.pending!
    redirect_to resource, notice: 'Coupon Book saved!'
  end

  def launch
    resource.launch!
    #update_screenshot(resource)

    if request.xhr?
      render nothing: true
    else
      redirect_to resource, notice: 'Coupon Book launched!'
    end
  end

  def toggle_visibility
    resource.toggle! :visible
    render nothing: true
  end

  #Sponsor landing
  def start_discount
    @coupon_book = resource.decorate
    @collection_id = @coupon_book.fundraiser.collection.id
  end

  def start_pr_box
    @coupon_book = resource.decorate
    @collection_id = @coupon_book.fundraiser.collection.id
  end

  def download
    ### Just for testing purposes ###
    respond_with(resource) do |format|
      format.html do
        pdf = CouponBookPdf.new(resource.decorate)
        send_data pdf.render, filename: "voucher.pdf", type: 'application/pdf'
      end
    end
  end

  private

  def redirect_to_coupon_template
    redirect_to new_coupon_path(fr_collection_id: resource.fundraiser.collection.id) if current_user.present? and current_sponsor.present?
  end

  def redirect_to_pr_box_template
    redirect_to new_pr_box_path(fr_collection_id: resource.fundraiser.collection.id) if current_user.present? and current_sponsor.present?
  end

  def redirect_to_billing
    unless resource.fundraiser.stripe_publishable_key.present?
      if request.xhr?
        render js: "window.location = #{cake_fundraiser_path(:billing).to_json}"
      else
        redirect_to cake_fundraiser_path(:billing)
      end
    end
  end

  def block_fr
    redirect_to coupon_books_path, alert: "You're not authorized to see this page." if current_fundraiser.present?
  end

  def permitted_params
    params.permit(coupon_book: [
      :name, :organization_name, :mission, :launch_date, :end_date, :story, :custom_pledge_levels, :goal,
      :headline, :step, :url, :main_cause, :sponsor_alias, :visitor_url, :visitor_action, :visible, :price, causes: [],
      scopes: [], video_attributes: [:id, :url, :auto_show],
      picture_attributes: [
        :id, :banner, :avatar, :avatar_caption,
        :avatar_crop_x, :avatar_crop_y, :avatar_crop_w, :avatar_crop_h,
        :banner_crop_x, :banner_crop_y, :banner_crop_w, :banner_crop_h
      ],
      categories_attributes: [:id, :position, categories_coupons_attributes: [:id, :position, :coupon_id, :category_id, :_destroy] ]
    ])
  end

  def categories_permitted_params(cat_params)
    cat_params = ActionController::Parameters.new(cat_params)
    cat_params.permit(categories_attributes: [
      :id, :position, categories_coupons_attributes: [:id, :position, :coupon_id, :category_id, :_destroy]
    ])
  end

  def update_screenshot(coupon_book)
    Resque.enqueue(ResqueSchedule::CouponBookScreenshot, coupon_book.id, coupon_book_url(coupon_book)) unless Rails.env.test?
  end

end
