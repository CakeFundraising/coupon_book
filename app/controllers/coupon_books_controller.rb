class CouponBooksController < InheritedResources::Base
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
  end

  #Template steps
  def basic_info
    @coupon_book = resource.decorate
    render 'coupon_books/template/basic_info'
  end

  def tell_your_story
    @coupon_book = resource.decorate
    render 'coupon_books/template/tell_your_story'
  end

  #Build coupon book
  def coupons
    @coupon_book = resource

    @collection = current_fundraiser.coupon_collection || current_fundraiser.create_coupon_collection
    @collections_coupons = @collection.coupons.latest.decorate

    @categories = resource.categories.with_coupons.decorate

    render 'coupon_books/template/coupons'
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
        redirect_to tell_your_story_coupon_book_path(@coupon_book)
      end
      failure.html do
        render action: :new
      end
    end
  end

  def update
    # puts permitted_params.to_yaml
    update! do |success, failure|
      success.html do
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
    redirect_to share_coupon_book_path(resource), notice: 'Coupon Book saved!'
  end

  def launch
    resource.launch!
    #update_coupon_book_screenshot(resource)

    if request.xhr?
      render nothing: true
    else
      redirect_to share_coupon_book_path(resource), notice: 'Coupon Book launched!'
    end
  end

  def toggle_visibility
    resource.toggle! :visible
    render nothing: true
  end

  private

  def permitted_params
    params.permit(coupon_book: [:name, :mission, :launch_date, :end_date, :story, :custom_pledge_levels, :goal, 
      :headline, :step, :url, :main_cause, :sponsor_alias, :visitor_url, :visitor_action, :visible, causes: [],
      scopes: [], video_attributes: [:id, :url, :auto_show],
      picture_attributes: [
        :id, :banner, :avatar, :avatar_caption,
        :avatar_crop_x, :avatar_crop_y, :avatar_crop_w, :avatar_crop_h,
        :banner_crop_x, :banner_crop_y, :banner_crop_w, :banner_crop_h
      ],
      categories_attributes: [:id, :position, categories_coupons_attributes: [:id, :position, :coupon_id, :category_id, :_destroy] ]
    ])
  end

end
